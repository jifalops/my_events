import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_events/controllers/database_controller.dart';
import 'package:my_events/models/events.dart';
import 'package:my_events/models/profiles.dart';

class EventController {
  Future<String> create(FirebaseUser user, String title, DateTime start) async {
    final id = db.generateId('events');
    final event = Event(
      title: title,
      start: start,
      creator: user.uid,
      attendees: {
        user.uid:
            Attendee(displayName: user.displayName, photoUrl: user.photoUrl)
      },
    );
    await db.write('events/$id',
        event.toJson()..['attendees'][user.uid]['joined'] = db.serverTimestamp);
    await db.update('profiles/${user.uid}', {
      'events/$id': ProfileEvent(title: title, start: start).toJson(),
      // This creates the user's profile data if it doesn't exist.
      // This saves [programming] time over checking if they exist when
      // authenticated and creating it then.
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

  Future<void> join(Event event, FirebaseUser user) async {
    await db.update('events/${event.id}/attendees/${user.uid}', {
      'displayName': user.displayName,
      'photoUrl': user.photoUrl,
      'joined': db.serverTimestamp,
    });
    await db.update('profiles/${user.uid}', {
      'events/${event.id}':
          ProfileEvent(title: event.title, start: event.start).toJson(),

      /// This might be the first time the profile is created
      'photoUrl': user.photoUrl,
      'displayName': user.displayName,
    });
  }
}
