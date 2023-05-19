import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/config/firebase/firebase_provider.dart';
import 'package:riverpod_training/config/utils/keys/firebase_key.dart';
import 'package:riverpod_training/data_models/account/account.dart';

part 'user_repository.g.dart';

@riverpod
class UserRepo extends _$UserRepo {
  @override
  CollectionReference<Account> build() {
    return ref
        .read(firestoreProvider)
        .collection(FirebaseUserKey.userCollection)
        .withConverter<Account>(
          fromFirestore: (snapshot, _) => Account.fromJson(snapshot.data()!),
          toFirestore: (Account value, _) => value.toJson(),
        );
  }

  Future<void> createUser(Account newAccount) async {
    await state.doc(newAccount.userId).set(newAccount);
  }
}
