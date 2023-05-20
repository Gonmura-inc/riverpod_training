import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/config/utils/enum/router_enum.dart';
import 'package:riverpod_training/config/utils/fontStyle/font_size.dart';
import 'package:riverpod_training/data_models/account/account.dart';
import 'package:riverpod_training/repo/user/user_repo.dart';

class EditMyUserPage extends HookConsumerWidget {
  const EditMyUserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myNameController = useTextEditingController();

    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: const Text('プロフィール編集')),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ref.watch(watchMyAccountProvider).when(
              data: (Account? myAccount) {
                if (myAccount == null) {
                  return const Text(
                    'エラーが発生しました。再度お試しください。',
                    style: TextStyle(fontSize: FontSize.large),
                  );
                }
                myNameController.text = myAccount.userName;
                return Column(
                  children: [
                    //マイネームを入れるフォーム
                    TextFormField(
                      controller: myNameController,
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
                      onPressed: () async {
                        await _updateMyAccount(
                          formKey,
                          myAccount,
                          myNameController,
                          ref,
                          context,
                        );
                      },
                      child: const Text('ユーザーネーム変更'),
                    )
                  ],
                );
              },
              error: (error, stackTrace) {
                return const Text(
                  'エラーが発生しました。再度お試しください。',
                  style: TextStyle(fontSize: FontSize.large),
                );
              },
              loading: () {
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateMyAccount(
      GlobalKey<FormState> formKey,
      Account myAccount,
      TextEditingController myNameController,
      WidgetRef ref,
      BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final Account updateAccount =
        myAccount.copyWith(userName: myNameController.text);

    await ref.read(userRepoProvider.notifier).updateUser(updateAccount);
    if (context.mounted) {
      context.goNamed(AppRoute.mypage.name);
    }
    return;
  }
}
