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
    ref.read(taskListProvider.notifier).updateTask(taskData);
    state = const AsyncData(null);
  }

  //タスク削除
  Future<void> deleteTask(Task taskData) async {
    state = const AsyncLoading();
    await ref.read(taskRepoProvider.notifier).deleteTask(taskData.taskId);
    ref.read(taskListProvider.notifier).deleteTask(taskData);
    state = const AsyncData(null);
  }
}

@riverpod
class TaskList extends _$TaskList {
  @override
  Future<List<Task>> build() async {
    return ref.read(taskRepoProvider.notifier).getTasks([]);
  }

  Future<void> getTasks() async {
    state = const AsyncLoading();
    final List<Task> addTaskList =
        await ref.read(taskRepoProvider.notifier).getTasks(state.value!);
    state.value!.addAll(addTaskList);
    state = AsyncData(state.value!);
  }

  //タスクリストからタスクを削除
  Future<void> deleteTask(Task taskData) async {
    state = const AsyncLoading();
    state.value!.remove(taskData);
    state = AsyncData(state.value!);
  }

  //タスクリストから特定のタスクを更新
  Future<void> updateTask(Task taskData) async {
    state = const AsyncLoading();
    //タスクデータを取得
    final Task updateTaskData =
        await ref.read(taskRepoProvider.notifier).getTask(taskData.taskId);

    final int index = state.value!.indexWhere(
      (Task task) {
        return task.taskId == taskData.taskId;
      },
    );
    state.value![index] = updateTaskData;
    state = AsyncData(state.value!);
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
