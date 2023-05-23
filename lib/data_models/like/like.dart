import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_training/data_models/timestamp_converter.dart';

part 'like.freezed.dart';
part 'like.g.dart';

@freezed
class Like with _$Like {
  factory Like({
    required String likeId,
    required String taskId,
    required String userId,
    @TimestampConverter() required Timestamp createdAt,
  }) = _Like;

  factory Like.fromJson(Map<String, dynamic> json) => _$LikeFromJson(json);
}
