import 'package:flutter/material.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/config/firebase/firebase_auth_error_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_training/config/firebase/firebase_provider.dart';
part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
class AuthRepo extends _$AuthRepo {
  late FirebaseAuth auth;
  @override
  User? build() {
    auth = ref.read(firebaseAuthProvider);

    return auth.currentUser;
  }

  Future<String> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      state = auth.currentUser;
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
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = auth.currentUser;
      return "success";
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      return FirebaseAuthErrorExt.fromCode(e.code).message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
    state = auth.currentUser;
  }

  Stream<User?> authStateChanges() {
    return auth.authStateChanges().map((User? currentUser) {
      state = currentUser;
      return state;
    });
  }
}
