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
  AsyncValue build() {
    return const AsyncData(null);
  }

  Future<void> addTask(String title) async {
    state = const AsyncLoading();
    Task newTask = Task(
      taskId: const Uuid().v4(),
      title: title,
      createdAt: Timestamp.now(),
      userId: ref.read(authRepoProvider)!.uid,
    );
    await ref.read(taskRepoProvider.notifier).addTask(newTask);
    state = const AsyncData(null);
  }

  Future<void> updateTask(Task taskData, String title) async {
    state = const AsyncLoading();
    final Task editTaskData = taskData.copyWith(
      title: title,
    );
    await ref.read(taskRepoProvider.notifier).updateTask(editTaskData);
    state = const AsyncData(null);
  }
}

@riverpod
Future<Task> getTaskController(GetTaskControllerRef ref, String taskId) {
  return ref.read(taskRepoProvider.notifier).getTask(taskId);
}

@riverpod
Stream<List<Task>> tasksStreamController(TasksStreamControllerRef ref) {
  return ref.read(taskRepoProvider.notifier).watchTasks();
}

@riverpod
Stream<List<Task>> watchMyTasksController(WatchMyTasksControllerRef ref) {
  return ref.read(taskRepoProvider.notifier).watchMyTasks();
}

@riverpod
Stream<Task> watchTaskController(WatchTaskControllerRef ref, String taskId) {
  return ref.read(taskRepoProvider).doc(taskId).snapshots().map(
        (DocumentSnapshot<Task> snapshot) => snapshot.data()!,
      );
}
