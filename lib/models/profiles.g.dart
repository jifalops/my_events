// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profiles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    id: json['id'] as String,
    displayName: json['displayName'] as String,
    photoUrl: json['photoUrl'] as String,
    events: (json['events'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k,
          e == null ? null : ProfileEvent.fromJson(e as Map<String, dynamic>)),
    ),
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'events': instance.events?.map((k, e) => MapEntry(k, e?.toJson())),
    };

ProfileEvent _$ProfileEventFromJson(Map<String, dynamic> json) {
  return ProfileEvent(
    id: json['id'] as String,
    title: json['title'] as String,
    start: Database.parseTimestamp(json['start']),
  );
}

Map<String, dynamic> _$ProfileEventToJson(ProfileEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'start': instance.start?.toIso8601String(),
    };
