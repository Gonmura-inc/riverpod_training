// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Like _$$_LikeFromJson(Map<String, dynamic> json) => _$_Like(
      likeId: json['likeId'] as String,
      taskId: json['taskId'] as String,
      userId: json['userId'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$$_LikeToJson(_$_Like instance) => <String, dynamic>{
      'likeId': instance.likeId,
      'taskId': instance.taskId,
      'userId': instance.userId,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
