import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ログイン"),
        centerTitle: true,
      ),
      body: Column(children: [
        const Text('メールアドレス'),
        TextFormField(),
        const Text('パスワード'),
        TextFormField(),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('ログイン')),
            ElevatedButton(onPressed: () {}, child: const Text('会員登録')),
          ],
        )
      ]),
    );
  }
}
