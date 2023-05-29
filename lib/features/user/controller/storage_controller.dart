import 'dart:typed_data';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/features/auth/controller/current_user_controller.dart';
import 'package:riverpod_training/features/user/repo/storage_repo.dart';

part 'storage_controller.g.dart';

@riverpod
class StorageController extends _$StorageController {
  @override
  AsyncValue build() {
    return const AsyncData(null);
  }

  Future<String> uploadImageAndGetUrl(Uint8List uint8list) async {
    state = const AsyncLoading();
    final url = await ref
        .read(storageRepoProvider.notifier)
        .uploadImageAndGetUrl(
            ref.read(currentUserControllerProvider)!.uid, uint8list);
    state = const AsyncData(null);
    return url;
  }

  Future<void> deleteImage() async {
    state = const AsyncLoading();
    await ref
        .read(storageRepoProvider.notifier)
        .deleteImage(ref.read(currentUserControllerProvider)!.uid);
    state = const AsyncData(null);
  }
}
