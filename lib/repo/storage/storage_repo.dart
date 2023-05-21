// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:html';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/config/firebase/firebase_instance_provider.dart';

part 'storage_repo.g.dart';

@riverpod
class StorageRepo extends _$StorageRepo {
  @override
  Reference build() {
    return ref.read(firebaseStorageInstanceProvider).ref();
  }

  //画像をアップロード
  Future<String> uploadImageAndGetUrl(
      String userId, Uint8List uint8list) async {
    var metadata = SettableMetadata(
      contentType: "image/jpeg",
    );
    //画像をアップロード
    final uploadTask =
        await state.child('users/$userId').putData(uint8list, metadata);
    //アップロードした画像のURLを取得
    final downloadUrl = await uploadTask.ref.getDownloadURL();
    return downloadUrl;
  }

  //画像を削除
  Future<void> deleteImage(String userId) async {
    await state.child('users/$userId').delete();
  }
}
