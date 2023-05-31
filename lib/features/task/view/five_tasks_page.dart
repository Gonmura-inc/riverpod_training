import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/common_widgets/task_list_tile.dart';
import 'package:riverpod_training/config/utils/enum/router_enum.dart';
import 'package:riverpod_training/features/task/controller/task_controller.dart';
import 'package:riverpod_training/features/task/data_model/task.dart';

class FiveTasksPage extends HookConsumerWidget {
  const FiveTasksPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print('最下部まできたよ');
        //limitを増やす
        ref.read(limitControllerProvider.notifier).increment();
      }
    });
    return Scaffold(
      body:
          //全体のタスク
          ref.watch(watchFiveTasksControllerProvider).when(
                //２回目以降のローディング分岐のウィジェット切り替えをskipするかどうか
                skipLoadingOnReload: true,
                // //1回目以降のローディング分岐のウィジェット切り替えをskipするかどうか
                // skipLoadingOnRefresh: true,
                data: (List<Task> taskList) {
                  return ListView.separated(
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      final Task taskData = taskList[index];
                      return Row(
                        children: [
                          Text('$index'),
                          Expanded(child: TaskListTile(taskData: taskData)),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const Divider(height: 0.5),
                    itemCount: taskList.length,
                  );
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
                error: (error, stackTrace) {
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
