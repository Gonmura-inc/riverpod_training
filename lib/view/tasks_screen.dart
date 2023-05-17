import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/routing/app_router.dart';

import 'package:riverpod_training/tasks_repository.dart';

class TasksScreen extends HookConsumerWidget {
  const TasksScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("タスク一覧画面"),
      ),
      body: Consumer(builder: (context, ref, child) {
        return ref.watch(tasksStreamProvider).when(
            data: (data) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    if (index == 0 || index == data.length + 1) {
                      return const SizedBox.shrink();
                    }
                    return ListTile(
                      title: Text(data[index - 1].title),
                      trailing: Text(data[index - 1]
                          .createdAt
                          .toDate()
                          .toString()
                          .substring(0, 10)),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const Divider(height: 0.5),
                  itemCount: data.length);
            },
            loading: () {
              return const CircularProgressIndicator();
            },
            error: (_, __) => const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Something went wrong",
                        style: TextStyle(fontSize: 32.0, color: Colors.black54),
                      ),
                      Text(
                        "Can\'t load items right now",
                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                      ),
                    ],
                  ),
                ));
      }),
      floatingActionButton: FloatingActionButton(
          tooltip: "新しいタスクを作成",
          child: const Icon(Icons.add),
          onPressed: () {
            context.goNamed(AppRoute.newTask.name);
          }),
    );
  }
}
