// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'userdata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserData _$$_UserDataFromJson(Map<String, dynamic> json) => _$_UserData(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$_UserDataToJson(_$_UserData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'imageUrl': instance.imageUrl,
    };
