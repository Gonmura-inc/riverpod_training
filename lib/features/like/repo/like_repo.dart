import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/config/firebase/firebase_instance_provider.dart';
import 'package:riverpod_training/config/utils/keys/firebase_key.dart';
import 'package:riverpod_training/features/like/data_model/like.dart';
import 'package:riverpod_training/features/task/data_model/task.dart';
import 'package:riverpod_training/features/auth/repo/auth_repo.dart';

part 'like_repo.g.dart';

@riverpod
class LikeRepo extends _$LikeRepo {
  @override
  CollectionReference<Like> build(String taskId) {
    return ref
        .read(firebaseFireStoreInstanceProvider)
        .collection(FirebaseTasksKey.taskCollection)
        .doc(taskId)
        .collection(FirebaseLikesKey.likeCollection)
        .withConverter<Like>(
          fromFirestore: (snapshot, _) => Like.fromJson(snapshot.data()!),
          toFirestore: (Like value, _) => value.toJson(),
        );
  }

  //likeドキュメント追加
  Future<void> addLike(Like addLikeData) async {
    await state.doc(addLikeData.likeId).set(addLikeData);
  }

  //likeドキュメント削除
  Future<void> deleteLike(String deleteLikeId) async {
    await state.doc(deleteLikeId).delete();
  }

  //likesコレクションのstream取得
  Stream<List<Like>> watchLikes() {
    return state.snapshots().map(
          (QuerySnapshot<Like> snapshot) =>
              snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }

  //自分がいいねしたlikeDocumentのstream取得
}
