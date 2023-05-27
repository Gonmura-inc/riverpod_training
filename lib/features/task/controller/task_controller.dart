import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/features/auth/repo/auth_repo.dart';
import 'package:riverpod_training/features/task/data_model/task.dart';
import 'package:riverpod_training/features/task/repo/task_repo.dart';
import 'package:uuid/uuid.dart';

part 'task_controller.g.dart';

@riverpod
class TaskController extends _$TaskController {
  @override
  build() {}

  Future<void> addTask(String title) async {
    Task newTask = Task(
      taskId: const Uuid().v4(),
      title: title,
      createdAt: Timestamp.now(),
      userId: ref.read(authRepoProvider)!.uid,
    );
    await ref.read(taskRepoProvider.notifier).addTask(newTask);
  }

  Future<void> updateTask(Task taskData, String title) async {
    final Task editTaskData = taskData.copyWith(
      title: title,
    );
    await ref.read(taskRepoProvider.notifier).updateTask(editTaskData);
  }

  Future<Task> getTask(String taskId) async {
    final Task taskData =
        await ref.read(taskRepoProvider.notifier).getTask(taskId);
    return taskData;
  }
}

@riverpod
Stream<List<Task>> tasksStreamController(TasksStreamControllerRef ref) {
  return ref.read(taskRepoProvider.notifier).watchTasks();
}

@riverpod
Stream<Task> watchTaskController(WatchTaskControllerRef ref, String taskId) {
  return ref.read(taskRepoProvider).doc(taskId).snapshots().map(
        (DocumentSnapshot<Task> snapshot) => snapshot.data()!,
      );
}
