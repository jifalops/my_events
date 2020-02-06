import 'package:json_annotation/json_annotation.dart';
import 'package:my_events/models/profiles.dart';

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
  final DateTime start;
  final List<ProfileRef> attendees;
  final ProfileRef creator;

  EventRef get ref => EventRef(id: id, title: title, start: start);

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}

/// Refers to an event, e.g. for displaying in a list.
@JsonSerializable()
class EventRef {
  const EventRef({
    this.id,
    this.title,
    this.start,
  });

  final String id;
  final String title;
  final DateTime start;

  factory EventRef.fromJson(Map<String, dynamic> json) =>
      _$EventRefFromJson(json);
  Map<String, dynamic> toJson() => _$EventRefToJson(this);
}
