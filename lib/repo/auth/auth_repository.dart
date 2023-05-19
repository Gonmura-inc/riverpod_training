import 'package:flutter/material.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/config/firebase/firebase_auth_error_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_training/config/firebase/firebase_provider.dart';
part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
class AuthRepo extends _$AuthRepo {
  @override
  FirebaseAuth build() {
    return ref.read(firebaseAuthProvider);
  }

  Future<String> signIn(String email, String password) async {
    try {
      await state.signInWithEmailAndPassword(email: email, password: password);
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
      await state.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "success";
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      return FirebaseAuthErrorExt.fromCode(e.code).message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await state.signOut();
  }

  Stream<User?> authStateChanges() => state.authStateChanges();
  User? get currentUser => state.currentUser;
}

@riverpod
Stream<User?> authStateChanges(AuthStateChangesRef ref) {
  return ref.watch(authRepoProvider).authStateChanges();
}
