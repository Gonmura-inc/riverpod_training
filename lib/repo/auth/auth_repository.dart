import 'package:flutter/material.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/config/firebase/firebase_auth_error_text.dart';
import 'package:riverpod_training/data_models/account/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'auth_repository.g.dart';

@riverpod
class AuthRepo extends _$AuthRepo {
  final _auth = FirebaseAuth.instance;
  @override
  build() {}

  Future<String> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      return FirebaseAuthErrorExt.fromCode(e.code).message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "success";
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return FirebaseAuthErrorExt.fromCode(e.code).message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> createUser(Account newUser) async {
    await state.doc(newUser.userId).set(newUser);
  }

  Stream<User?> authStateChanges() => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;
}

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) {
  return FirebaseAuth.instance;
}

@riverpod
Stream<User?> authStateChanges(AuthStateChangesRef ref) {
  return ref.watch(authRepoProvider).authStateChanges();
}
