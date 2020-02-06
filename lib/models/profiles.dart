import 'package:json_annotation/json_annotation.dart';
import 'package:my_events/firebase_helpers/database.dart';

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
  final Map<String, ProfileEvent> events;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

/// Refers to an event, e.g. for displaying in a list.
@JsonSerializable()
class ProfileEvent {
  const ProfileEvent({
    this.id,
    this.title,
    this.start,
  });

  final String id;
  final String title;

  @JsonKey(fromJson: Database.parseTimestamp)
  final DateTime start;

  factory ProfileEvent.fromJson(Map<String, dynamic> json) =>
      _$ProfileEventFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileEventToJson(this);
}
