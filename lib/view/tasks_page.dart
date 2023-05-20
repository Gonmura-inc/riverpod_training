import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/data_models/task/task.dart';
import 'package:riverpod_training/repo/auth/auth_repo.dart';
import 'package:riverpod_training/repo/task/task_repo.dart';

import '../config/utils/enum/router_enum.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("タスク一覧画面"),
        actions: [
          IconButton(
              onPressed: () {
                //ログアウト
                ref.read(authRepoProvider.notifier).signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: ref.watch(tasksStreamProvider).when(data: (List<Task> taskList) {
        return ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                context.goNamed(
                  AppRoute.editTask.name,
                  queryParameters: {
                    "taskId": taskList[index].taskId,
                  },
                );
              },
              title: Text(taskList[index].title),
              trailing: Text(taskList[index]
                  .createdAt
                  .toDate()
                  .toString()
                  .substring(0, 16)),
            );
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
