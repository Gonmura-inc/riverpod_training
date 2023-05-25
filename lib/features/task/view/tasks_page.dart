import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/features/task/data_model/task.dart';
import 'package:riverpod_training/features/task/repo/task_repo.dart';
import 'package:riverpod_training/common_widgets/task_list_tile.dart';

import '../../../config/utils/enum/router_enum.dart';

class TasksScreen extends HookConsumerWidget {
  const TasksScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("タスク一覧画面"),
      ),
      body: ref.watch(tasksStreamProvider).when(data: (List<Task> taskList) {
        return ListView.separated(
          itemBuilder: (context, index) {
            final Task taskData = taskList[index];
            return TaskListTile(taskData: taskData);
          },
          separatorBuilder: (context, index) => const Divider(height: 0.5),
          itemCount: taskList.length,
        );
      }, loading: () {
        return const CircularProgressIndicator();
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
