import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_training/task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tasks_repository.g.dart';

class TasksRepository {
  const TasksRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Stream<List<Task>> watchTasks() {
    return _firestore
        .collection("tasks")
        .withConverter<Task>(
          fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson(),
        )
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}

@Riverpod(keepAlive: true)
TasksRepository tasksRepository(TasksRepositoryRef ref) {
  return TasksRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<Task>> tasksStream(TasksStreamRef ref) {
  final repository = ref.watch(tasksRepositoryProvider);
  return repository.watchTasks();
}
