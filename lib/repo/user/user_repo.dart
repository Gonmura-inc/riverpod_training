import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/config/firebase/firebase_instance_provider.dart';
import 'package:riverpod_training/config/utils/keys/firebase_key.dart';
import 'package:riverpod_training/data_models/account/account.dart';
import 'package:riverpod_training/repo/auth/auth_repo.dart';

part 'user_repo.g.dart';

@riverpod
class UserRepo extends _$UserRepo {
  @override
  CollectionReference<Account> build() {
    return ref
        .read(firebaseFireStoreInstanceProvider)
        .collection(FirebaseUserKey.userCollection)
        .withConverter<Account>(
          fromFirestore: (snapshot, _) => Account.fromJson(snapshot.data()!),
          toFirestore: (Account value, _) => value.toJson(),
        );
  }

  //ドキュメント追加
  Future<void> createUser(Account addAccount) async {
    await state.doc(addAccount.userId).set(addAccount);
  }

  //ドキュメント更新
  Future<void> updateUser(Account updateAccount) async {
    await state.doc(updateAccount.userId).update(updateAccount.toJson());
  }

  //ドキュメント削除
  Future<void> deleteUser(String deleteAccountUserId) async {
    await state.doc(deleteAccountUserId).delete();
  }

  //1件Userドキュメント取得
  Future<Account?> getAccount(String accountUserId) async {
    final snapshot = await state.doc(accountUserId).get();
    return snapshot.data();
  }

  //Streamでuserドキュメント取得
  Stream<Account?> watchAccount(String accountUserId) {
    return state.doc(accountUserId).snapshots().map(
          (DocumentSnapshot<Account> snapshot) => snapshot.data(),
        );
  }

  //コレクション取得
  Future<List<Account>> getAccounts() async {
    final snapshot = await state.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  //streamでuserListを取得
  Stream<List<Account>> watchUsers() {
    return state
        .orderBy(FirebaseUserKey.createdAt, descending: true)
        .snapshots()
        .map(
      (QuerySnapshot<Account> snapshot) {
        return snapshot.docs.map(
          (QueryDocumentSnapshot<Account> doc) {
            return doc.data();
          },
        ).toList();
      },
    );
  }
}

@riverpod
Stream<Account?> watchAccount(WatchAccountRef ref, String userId) {
  return ref.watch(userRepoProvider.notifier).watchAccount(userId);
}

//自分のユーザードキュメントを監視するプロバイダー
@riverpod
Stream<Account?> watchMyAccount(WatchMyAccountRef ref) {
  return ref
      .watch(userRepoProvider.notifier)
      .watchAccount(ref.watch(authRepoProvider)!.uid);
}
