import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/data_models/task/task.dart';
import 'package:riverpod_training/repo/tasks_repository.dart';

import 'package:uuid/uuid.dart';

import '../config/utils/enum/router_enum.dart';

class NewTaskScreen extends HookConsumerWidget {
  const NewTaskScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskTitleController = useTextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: const Text("新しいタスクを追加")),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
                  if (formKey.currentState!.validate()) {
                    _createNewTask(
                      context: context,
                      ref: ref,
                      title: taskTitleController.text,
                    );
                  }
                },
                child: const Text('タスクを作成'),
              )
            ],
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
      debugPrint(e.toString());
    }
  }
}
