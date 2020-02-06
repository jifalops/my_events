import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_events/controllers/database_controller.dart';
import 'package:my_events/models/events.dart';
import 'package:my_events/models/profiles.dart';

class EventController {
  Future<String> create(FirebaseUser user, String title, DateTime start) async {
    final id = db.generateId('events');
    final me = ProfileRef.fromUser(user);
    final event =
        Event(id: id, title: title, start: start, creator: me, attendees: [me]);
    await db.write('events/$id', event.toJson()..remove('id'));
    await db.update('profiles/${user.uid}', {
      'events/$id': event.ref.toJson()..remove('id'),
      // This side effect saves time by lazily creating a user's profile in the
      // database, rather than checking if it exists when authenticated and
      // creating it then.
      'photoUrl': user.photoUrl,
      'displayName': user.displayName,
    });
    return id;
  }

  Future<Event> read(String id) async {
    final data = await db.read('events/$id');
    return data == null ? null : Event.fromJson(data..['id'] = id);
  }

  Stream<Event> stream(String id) => db
      .stream('events/$id')
      .map((data) => data == null ? null : Event.fromJson(data..['id'] = id));
}
