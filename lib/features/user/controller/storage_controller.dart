import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/features/auth/contoller/auth_controller.dart';
import 'package:riverpod_training/features/user/repo/storage_repo.dart';

part 'storage_controller.g.dart';

@riverpod
class StorageController extends _$StorageController {
  @override
  build() {}

  Future<String> uploadImageAndGetUrl(Uint8List uint8list) async {
    return await ref
        .read(storageRepoProvider.notifier)
        .uploadImageAndGetUrl(ref.read(authControllerProvider)!.uid, uint8list);
  }

  Future<void> deleteImage() async {
    await ref
        .read(storageRepoProvider.notifier)
        .deleteImage(ref.read(authControllerProvider)!.uid);
  }
}
