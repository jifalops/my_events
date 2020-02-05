import 'package:json_annotation/json_annotation.dart';
import 'package:my_events/models/events.dart';

part 'profiles.g.dart';

/// A user's public profile.
@JsonSerializable()
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

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

/// Refers to a user's profile, e.g. for displaying in a list.
@JsonSerializable()
class ProfileRef {
  const ProfileRef({
    this.id,
    this.displayName,
    this.photoUrl,
  });

  final String id;
  final String displayName;
  final String photoUrl;

  factory ProfileRef.fromJson(Map<String, dynamic> json) => _$ProfileRefFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileRefToJson(this);
}
