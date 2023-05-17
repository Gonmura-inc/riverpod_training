import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NewTaskScreen extends HookConsumerWidget {
  const NewTaskScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("新しいタスクを追加")),
      body: Container(),
    );
  }
}
