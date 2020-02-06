import 'package:json_annotation/json_annotation.dart';
import 'package:my_events/firebase_helpers/database.dart';

part 'events.g.dart';

/// An awesome event you should probably attend.
@JsonSerializable()
class Event {
  const Event({
    this.id,
    this.title,
    this.start,
    this.attendees,
    this.creator,
  });

  final String id;
  final String title;

  @JsonKey(fromJson: Database.parseTimestamp)
  final DateTime start;
  final Map<String, Attendee> attendees;
  final String creator;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}

/// Keep attendee data as part of the event to reduce queries. This approach
/// of allowing duplicate data is common in no-SQL databases like Firebase.
@JsonSerializable()
class Attendee {
  const Attendee({
    this.id,
    this.displayName,
    this.photoUrl,
    this.joined,
  });

  final String id;
  final String displayName;
  final String photoUrl;

  @JsonKey(fromJson: Database.parseTimestamp)
  final DateTime joined;

  factory Attendee.fromJson(Map<String, dynamic> json) =>
      _$AttendeeFromJson(json);
  Map<String, dynamic> toJson() => _$AttendeeToJson(this);
}
