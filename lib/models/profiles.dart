import 'package:my_events/models/events.dart';

/// A user's public profile.
class Profile {
  const Profile({
    this.id,
    this.displayName,
    this.photoUrl,
    this.events,
  });

  final String id;
  final String displayName;
  final String photoUrl;
  final List<EventRef> events;
}

/// Refers to a user's profile, e.g. for displaying in a list.
class ProfileRef {
  const ProfileRef({
    this.id,
    this.displayName,
    this.photoUrl,
  });

  final String id;
  final String displayName;
  final String photoUrl;
}
