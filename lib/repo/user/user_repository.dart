import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/config/utils/keys/firebase_key.dart';
import 'package:riverpod_training/data_models/account/account.dart';

part 'user_repository.g.dart';

@riverpod
class UserRepo extends _$UserRepo {
  @override
  build() {
    return FirebaseFirestore.instance
        .collection(FirebaseKey.userCollection)
        .withConverter<Account>(
          fromFirestore: (snapshot, _) => Account.fromJson(snapshot.data()!),
          toFirestore: (Account value, _) => value.toJson(),
        );
  }

  Future<void> createUser(Account newAccount) async {
    await state.doc(newAccount.userId).set(newAccount);
  }
}
