import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/config/utils/enum/router_enum.dart';
import 'package:riverpod_training/data_models/account/account.dart';
import 'package:riverpod_training/repo/auth/auth_repo.dart';
import 'package:riverpod_training/repo/user/user_repo.dart';

class AuthPage extends HookConsumerWidget {
  const AuthPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passController = useTextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '未入力ですよ';
                }
                return null;
              },
            ),
            TextFormField(
              controller: passController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '未入力ですよ';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) {
                  return;
                }
                //ログイン処理
                final String createUserResult =
                    await ref.read(authRepoProvider.notifier).signIn(
                          email: emailController.text,
                          password: passController.text,
                        );
                if (createUserResult == 'success') {
                  if (context.mounted) {
                    context.goNamed(AppRoute.tasks.name);
                  }
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(createUserResult),
                    ));
                  }
                }
              },
              child: const Text('ログイン'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) {
                  return;
                }
                //会員登録処理
                final String createUserResult =
                    await ref.read(authRepoProvider.notifier).createUser(
                          email: emailController.text,
                          password: passController.text,
                        );
                if (createUserResult == 'success') {
                  Account addAccount = Account(
                    userId: ref.read(authRepoProvider)!.uid,
                    userName: '',
                    createdAt: Timestamp.now(),
                  );
                  await ref
                      .read(userRepoProvider.notifier)
                      .createUser(addAccount);
                  if (context.mounted) {
                    context.goNamed(AppRoute.tasks.name);
                  }
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(createUserResult),
                    ));
                  }
                }
              },
              child: const Text('会員登録'),
            ),
          ],
        ),
      ),
    );
  }
}
