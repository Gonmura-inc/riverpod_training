import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:riverpod_training/config/utils/keys/firebase_key.dart';
import 'package:riverpod_training/data_models/task/task.dart';

class TaskRepo {
  final db = FirebaseFirestore.instance
      .collection(FirebaseTaskKey.taskCollection)
      .withConverter<Task>(
        fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
        toFirestore: (Task value, _) => value.toJson(),
      );

  Stream<List<Task>> watchTasks() {
    return db.orderBy('createdAt', descending: true).snapshots().map(
      (QuerySnapshot<Task> snapshot) {
        return snapshot.docs.map(
          (QueryDocumentSnapshot<Task> doc) {
            return doc.data();
          },
        ).toList();
      },
    );
  }

  Stream<Task> watchTask() {
    return db.doc('docId').snapshots().map(
      (DocumentSnapshot<Task> snapshot) {
        return snapshot.data()!;
      },
    );
  }

  Future<void> addTask(Task addTaskData) async {
    await db.doc(addTaskData.taskId).set(addTaskData);
  }
}
