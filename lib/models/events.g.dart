// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    id: json['id'] as String,
    title: json['title'] as String,
    start: Database.parseTimestamp(json['start']),
    attendees: (json['attendees'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : Attendee.fromJson(e as Map<String, dynamic>)),
    ),
    creator: json['creator'] as String,
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'start': instance.start?.toIso8601String(),
      'attendees': instance.attendees?.map((k, e) => MapEntry(k, e?.toJson())),
      'creator': instance.creator,
    };

Attendee _$AttendeeFromJson(Map<String, dynamic> json) {
  return Attendee(
    id: json['id'] as String,
    displayName: json['displayName'] as String,
    photoUrl: json['photoUrl'] as String,
    joined: Database.parseTimestamp(json['joined']),
  );
}

Map<String, dynamic> _$AttendeeToJson(Attendee instance) => <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'joined': instance.joined?.toIso8601String(),
    };
