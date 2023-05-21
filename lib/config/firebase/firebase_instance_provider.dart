import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_instance_provider.g.dart';

@riverpod
FirebaseFirestore firebaseFireStoreInstance(FirebaseFireStoreInstanceRef ref) {
  return FirebaseFirestore.instance;
}

@riverpod
FirebaseAuth firebaseAuthInstance(FirebaseAuthInstanceRef ref) {
  return FirebaseAuth.instance;
}

@riverpod
FirebaseStorage firebaseStorageInstance(FirebaseStorageInstanceRef ref) {
  return FirebaseStorage.instance;
}
