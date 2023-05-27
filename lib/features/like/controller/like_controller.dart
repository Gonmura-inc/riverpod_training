import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/config/firebase/firebase_instance_provider.dart';
import 'package:riverpod_training/config/utils/keys/firebase_key.dart';
import 'package:riverpod_training/features/auth/contoller/auth_controller.dart';
import 'package:riverpod_training/features/auth/repo/auth_repo.dart';
import 'package:riverpod_training/features/like/data_model/like.dart';
import 'package:riverpod_training/features/like/repo/like_repo.dart';
import 'package:uuid/uuid.dart';
part 'like_controller.g.dart';

@riverpod
class LikeController extends _$LikeController {
  @override
  build() {}

  Future<void> deleteLike(String taskId, String deleteLikeId) async {
    await ref.read(likeRepoProvider(taskId).notifier).deleteLike(deleteLikeId);
  }

  Future<void> addLike(
    String taskId,
  ) async {
    //いいねをする
    final Like addLikeData = Like(
      likeId: const Uuid().v4(),
      taskId: taskId,
      userId: ref.read(authRepoProvider)!.uid,
      createdAt: Timestamp.now(),
    );
    await ref.read(likeRepoProvider(taskId).notifier).addLike(addLikeData);
  }

  String getMyLikeId(List<Like> likeList) {
    String myLikeId = '';
    for (final Like likeData in likeList) {
      if (likeData.userId == ref.read(authControllerProvider)!.uid) {
        myLikeId = likeData.likeId;
        break;
      }
    }
    return myLikeId;
  }
}

@riverpod
Stream<List<Like>> watchLikesController(
    WatchLikesControllerRef ref, String taskId) {
  return ref.read(likeRepoProvider(taskId).notifier).watchLikes();
}

@riverpod
Stream<List<Like>> watchMyLikesController(WatchMyLikesControllerRef ref) {
  return ref
      .read(firebaseFireStoreInstanceProvider)
      .collectionGroup(FirebaseLikesKey.likeCollection)
      .withConverter<Like>(
        fromFirestore: (snapshot, _) => Like.fromJson(snapshot.data()!),
        toFirestore: (Like value, _) => value.toJson(),
      )
      .where(FirebaseLikesKey.userId,
          isEqualTo: ref.read(authRepoProvider)!.uid)
      .snapshots()
      .map(
    (QuerySnapshot<Like> snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    },
  );
}
