// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Task _$$_TaskFromJson(Map<String, dynamic> json) => _$_Task(
      id: json['id'],
      owner: json['owner'] == null
          ? null
          : User.fromJson(json['owner'] as Map<String, dynamic>),
      ownerBy: User.fromJson(json['ownerBy'] as Map<String, dynamic>),
      owners: (json['owners'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      checks: (json['checks'] as List<dynamic>)
          .map((e) => Check.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_TaskToJson(_$_Task instance) => <String, dynamic>{
      'id': instance.id,
      'owner': instance.owner,
      'ownerBy': instance.ownerBy,
      'owners': instance.owners,
      'checks': instance.checks,
    };
