import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/data_models/account/account.dart';
import 'package:riverpod_training/repo/auth/auth_repository.dart';
import 'package:riverpod_training/repo/user/user_repository.dart';
import 'package:uuid/uuid.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("ログイン"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Column(children: [
          const Text('メールアドレス'),
          TextFormField(
            controller: emailController,
            validator: (value) {
              if (value == "") {
                return "必須入力項目です";
              }
            },
          ),
          const Text('パスワード'),
          TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value == "") {
                return "必須入力項目です";
              }
            },
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _signIn(
                        ref: ref,
                        context: context,
                        emailController: emailController,
                        passwordController: passwordController,
                      );
                    }
                  },
                  child: const Text('ログイン')),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _register(
                      ref: ref,
                      emailController: emailController,
                      passwordController: passwordController,
                    );
                  }
                },
                child: const Text('会員登録'),
              ),
            ],
          )
        ]),
      ),
    );
  }

  void _signIn({
    required WidgetRef ref,
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    final String signInMessage = await ref.read(authRepoProvider).signIn(
          emailController.text,
          passwordController.text,
        );
    if (signInMessage != "success") {
      debugPrint(signInMessage);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(signInMessage)));
      return;
    }
    emailController.clear();
    passwordController.clear();
  }

  void _register({
    required WidgetRef ref,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    final String registerMessage = await ref.read(authRepoProvider).register(
          emailController.text,
          passwordController.text,
        );
    //サインインに成功した場合
    if (registerMessage == "success") {
      //ユーザー情報のインスタンスを作成
      final User currentUser = ref.read(authRepoProvider).currentUser!;
      final Account account = Account(
          userId: currentUser.uid,
          email: emailController.text,
          createdAt: Timestamp.now());
      await ref.read(userRepoProvider.notifier).createUser(account);
    } else {
      debugPrint(registerMessage);
      return;
    }
    emailController.clear();
    passwordController.clear();
  }
}
