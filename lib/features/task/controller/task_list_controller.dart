import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/features/task/data_model/task.dart';
import 'package:riverpod_training/features/task/repo/task_repo.dart';
part 'task_list_controller.g.dart';

@riverpod
class TaskListController extends _$TaskListController {
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
