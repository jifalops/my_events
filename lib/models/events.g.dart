// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    id: json['id'] as String,
    title: json['title'] as String,
    start:
        json['start'] == null ? null : DateTime.parse(json['start'] as String),
    attendees: (json['attendees'] as List)
        ?.map((e) =>
            e == null ? null : ProfileRef.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'start': instance.start?.toIso8601String(),
      'attendees': instance.attendees?.map((e) => e?.toJson())?.toList(),
    };

EventRef _$EventRefFromJson(Map<String, dynamic> json) {
  return EventRef(
    id: json['id'] as String,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$EventRefToJson(EventRef instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
