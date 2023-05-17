import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/app_router.dart';

class TasksScreen extends HookConsumerWidget {
  const TasksScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("タスク一覧画面"),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
          tooltip: "新しいタスクを作成",
          child: const Icon(Icons.add),
          onPressed: () {
            context.goNamed(AppRoute.newTask.name);
          }),
    );
  }
}
