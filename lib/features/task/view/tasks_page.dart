import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/features/task/controller/task_controller.dart';
import 'package:riverpod_training/features/task/data_model/task.dart';
import 'package:riverpod_training/common_widgets/task_list_tile.dart';

import '../../../config/utils/enum/router_enum.dart';

class TasksScreen extends HookConsumerWidget {
  const TasksScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMyTasks = useState(false);
    return Scaffold(
      appBar: AppBar(
        leading: ref.watch(watchMyTasksControllerProvider).when(
          error: (error, stackTrace) {
            return const SizedBox.shrink();
          },
          loading: () {
            return const SizedBox.shrink();
          },
          data: (List<Task> myTaskList) {
            return Center(child: Text('タスク数：${myTaskList.length}'));
          },
        ),
        title: const Text("タスク一覧画面"),
        actions: [
          IconButton(
              onPressed: () {
                isMyTasks.value = !isMyTasks.value;
              },
              icon: const Icon(Icons.change_circle))
        ],
      ),
      body: (isMyTasks.value)
          ?
          //自分のタスク
          ref.watch(watchMyTasksControllerProvider).when(
              data: (List<Task> taskList) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final Task taskData = taskList[index];
                  return TaskListTile(taskData: taskData);
                },
                separatorBuilder: (context, index) =>
                    const Divider(height: 0.5),
                itemCount: taskList.length,
              );
            }, loading: () {
              return const Center(child: CircularProgressIndicator());
            }, error: (error, stackTrace) {
              return const Center(child: Text('エラーだよ'));
            })
          //全体のタスク
          : ref.watch(tasksStreamControllerProvider).when(
              data: (List<Task> taskList) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final Task taskData = taskList[index];
                  return TaskListTile(taskData: taskData);
                },
                separatorBuilder: (context, index) =>
                    const Divider(height: 0.5),
                itemCount: taskList.length,
              );
            }, loading: () {
              return const Center(child: CircularProgressIndicator());
            }, error: (error, stackTrace) {
              return const Center(child: Text('エラーだよ'));
            }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.goNamed(AppRoute.newTask.name);
        },
      ),
    );
  }
}
