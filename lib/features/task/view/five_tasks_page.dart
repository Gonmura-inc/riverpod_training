import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FiveTasksPage extends HookConsumerWidget {
  const FiveTasksPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('5件ずつ'),
    );
  }
}
