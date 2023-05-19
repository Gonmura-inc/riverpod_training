import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:riverpod_training/config/utils/keys/firebase_key.dart';
import 'package:riverpod_training/data_models/task/task.dart';

class TaskRepo {
  final db = FirebaseFirestore.instance
      .collection(FirebaseKey.taskCollection)
      .withConverter<Task>(
        fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
        toFirestore: (Task value, _) => value.toJson(),
      );

  Stream<List<Task>> watchTasks() {
    return db.orderBy('createdAt', descending: true).snapshots().map(
      (snapshot) {
        return snapshot.docs.map(
          (doc) {
            return doc.data();
          },
        ).toList();
      },
    );
  }

  Future<void> addTask(Task addTaskData) async {
    await db.doc(addTaskData.taskId).set(addTaskData);
  }
}
