import 'package:my_events/models/profiles.dart';

/// An awesome event you should probably attend.
class Event {
  const Event({
    this.id,
    this.title,
    this.start,
    this.attendees,
  });

  final String id;
  final String title;
  final DateTime start;
  final List<ProfileRef> attendees;
}

/// Refers to an event, e.g. for displaying in a list.
class EventRef {
  const EventRef({
    this.id,
    this.title,
  });

  final String id;
  final String title;
}