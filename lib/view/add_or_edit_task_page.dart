import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/data_models/task/task.dart';
import 'package:riverpod_training/functions/show_snack_bar.dart';
import 'package:riverpod_training/repo/task/task_repo.dart';

import 'package:uuid/uuid.dart';

import '../config/utils/enum/router_enum.dart';

class AddOrEditTaskPage extends HookConsumerWidget {
  const AddOrEditTaskPage({super.key, this.taskId});
  final String? taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskTitleController = useTextEditingController();
    late Task taskData;
    Future(() async {
      if (taskId != null) {
        taskData = await ref.read(taskRepoProvider.notifier).getTask(taskId!);
        taskTitleController.text = taskData.title;
      }
    });

    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: Text(taskId == null ? "タスクを作成" : 'タスクを編集')),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                //タスクのタイトルを入れるフォーム
                TextFormField(
                  controller: taskTitleController,
                  validator: (value) {
                    if (value == "") {
                      return "必須入力項目です";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                //タスク追加ボタン
                ElevatedButton(
                  onPressed: () {
                    //タスクを作る処理（ロジック）はview(見た目)とは関係がないので、
                    //メソッドを作成して見た目に関わるコードから分離するのが良い
                    //_(アンダースコア)をつけて関数名を定義し、
                    //関数にカーソルを当てた状態でcmd+.を押すとcreate methodという候補を選択
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    if (taskId == null) {
                      _createNewTask(
                        context: context,
                        ref: ref,
                        title: taskTitleController.text,
                      );
                    } else {
                      //タスクを編集する処理
                      _editTask(
                          context: context,
                          ref: ref,
                          title: taskTitleController.text,
                          taskData: taskData);
                    }
                  },
                  child: Text(taskId == null ? 'タスクを作成' : 'タスクを編集'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createNewTask({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
  }) async {
    //taskデータクラスのインスタンスを作成
    //taskIdはuuidパッケージを使ってランダムなidを自動で生成
    try {
      Task newTask = Task(
        taskId: const Uuid().v4(),
        title: title,
        createdAt: Timestamp.now(),
      );
      await ref.read(taskRepoProvider.notifier).addTask(newTask);

      if (context.mounted) {
        context.goNamed(AppRoute.tasks.name);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void _editTask({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required Task taskData,
  }) async {
    try {
      final Task editTaskData = taskData.copyWith(
        title: title,
      );
      await ref.read(taskRepoProvider.notifier).updateTask(editTaskData);
      if (context.mounted) {
        context.goNamed(AppRoute.tasks.name);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
