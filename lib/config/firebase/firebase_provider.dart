import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_provider.g.dart';

@riverpod
FirebaseFirestore firestoreInstance(FirestoreInstanceRef ref) {
  return FirebaseFirestore.instance;
}

@riverpod
FirebaseAuth firebaseAuthInstance(FirebaseAuthInstanceRef ref) {
  return FirebaseAuth.instance;
}
