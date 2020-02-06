import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_events/controllers/database_controller.dart';
import 'package:my_events/models/profiles.dart';

class ProfileController {
  Future<void> create(FirebaseUser user) async {
    await db.write('profiles/${user.uid}', {
      'displayName': user.displayName,
      'photoUrl': user.photoUrl,
    });
  }

  Future<Profile> read(String id) async {
    final data = await db.read('profiles/$id');
    return data == null ? null : Profile.fromJson(data..['id'] = id);
  }

  Stream<Profile> stream(String id) => db
      .stream('profiles/$id')
      .map((data) => data == null ? null : Profile.fromJson(data..['id'] = id));

  Stream<Map<String, Profile>> streamAllProfiles() =>
      db.stream('profiles').map((data) {
        if (data == null) return null;
        return data.map((id, profileData) =>
            MapEntry(id, Profile.fromJson(profileData..['id'] = id)));
      });

  Future<void> updateDisplayName(String id, String displayName) =>
      db.update('profiles/$id', {'displayName': displayName});
  Future<void> updatePhotoUrl(String id, String photoUrl) =>
      db.update('profiles/$id', {'photoUrl': photoUrl});
}
