import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/data_models/task/task.dart';
import 'package:riverpod_training/repo/tasks_repository.dart';

import '../config/utils/enum/router_enum.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("タスク一覧画面"),
      ),
      body: StreamBuilder(
        stream: TaskRepo().watchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            final List<Task> data = snapshot.data!;
            return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index].title),
                  trailing: Text(data[index]
                      .createdAt
                      .toDate()
                      .toString()
                      .substring(0, 10)),
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 0.5),
              itemCount: data.length,
            );
          }
          return const Center(child: Text('エラーだよ'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.goNamed(AppRoute.newTask.name);
        },
      ),
    );
  }
}
