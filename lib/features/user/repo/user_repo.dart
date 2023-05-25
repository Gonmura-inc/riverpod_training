import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/config/firebase/firebase_instance_provider.dart';
import 'package:riverpod_training/config/utils/keys/firebase_key.dart';
import 'package:riverpod_training/features/user/data_model/userdata.dart';

import 'package:riverpod_training/features/auth/repo/auth_repo.dart';

part 'user_repo.g.dart';

@riverpod
class UserRepo extends _$UserRepo {
  @override
  CollectionReference<UserData> build() {
    return ref
        .read(firebaseFireStoreInstanceProvider)
        .collection(FirebaseUserKey.userCollection)
        .withConverter<UserData>(
          fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
          toFirestore: (UserData value, _) => value.toJson(),
        );
  }

  //ドキュメント追加
  Future<void> createUser(UserData addAccount) async {
    await state.doc(addAccount.userId).set(addAccount);
  }

  //ドキュメント更新
  Future<void> updateUser(UserData updateAccount) async {
    await state.doc(updateAccount.userId).update(updateAccount.toJson());
  }

  //ドキュメント削除
  Future<void> deleteUser(String deleteAccountUserId) async {
    await state.doc(deleteAccountUserId).delete();
  }

  //1件Userドキュメント取得
  Future<UserData?> getAccount(String accountUserId) async {
    final snapshot = await state.doc(accountUserId).get();
    return snapshot.data();
  }

  //Streamでuserドキュメント取得
  Stream<UserData?> watchAccount(String accountUserId) {
    return state.doc(accountUserId).snapshots().map(
          (DocumentSnapshot<UserData> snapshot) => snapshot.data(),
        );
  }

  //コレクション取得
  Future<List<UserData>> getAccounts() async {
    final snapshot = await state.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  //streamでuserListを取得
  Stream<List<UserData>> watchUsers() {
    return state
        .orderBy(FirebaseUserKey.createdAt, descending: true)
        .snapshots()
        .map(
      (QuerySnapshot<UserData> snapshot) {
        return snapshot.docs.map(
          (QueryDocumentSnapshot<UserData> doc) {
            return doc.data();
          },
        ).toList();
      },
    );
  }
}

@riverpod
Stream<List<UserData>> watchUsers(WatchUsersRef ref) {
  return ref.watch(userRepoProvider.notifier).watchUsers();
}

@riverpod
Stream<UserData?> watchAccount(WatchAccountRef ref, String userId) {
  return ref.watch(userRepoProvider.notifier).watchAccount(userId);
}

//自分のユーザードキュメントを監視するプロバイダー
@riverpod
Stream<UserData?> watchMyAccount(WatchMyAccountRef ref) {
  return ref
      .watch(userRepoProvider.notifier)
      .watchAccount(ref.watch(authRepoProvider)!.uid);
}
