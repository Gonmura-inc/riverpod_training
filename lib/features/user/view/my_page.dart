import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/config/utils/enum/router_enum.dart';
import 'package:riverpod_training/config/utils/fontStyle/font_size.dart';
import 'package:riverpod_training/config/utils/margin/height_margin.dart';
import 'package:riverpod_training/features/auth/contoller/auth_controller.dart';
import 'package:riverpod_training/features/auth/contoller/current_user_controller.dart';
import 'package:riverpod_training/features/like/controller/like_controller.dart';
import 'package:riverpod_training/features/like/data_model/like.dart';
import 'package:riverpod_training/features/task/controller/task_controller.dart';
import 'package:riverpod_training/features/task/data_model/task.dart';
import 'package:riverpod_training/features/user/controller/user_controller.dart';
import 'package:riverpod_training/features/user/data_model/userdata.dart';
import 'package:riverpod_training/functions/show_snack_bar.dart';
import 'package:riverpod_training/common_widgets/task_list_tile.dart';

class MyPage extends HookConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passController = useTextEditingController();
    final newEmailController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
        actions: [
          IconButton(
              onPressed: () {
                //ログアウト
                ref.read(authControllerProvider.notifier).signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              HeightMargin.normal,
              ref.watch(watchMyAccountControllerProvider).when(
                data: (UserData? userData) {
                  if (userData == null) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      (userData.imageUrl == null || userData.imageUrl == '')
                          ? const Icon(
                              Icons.person,
                              size: 100,
                            )
                          : ClipOval(
                              child: SizedBox(
                                width: 200,
                                height: 200,
                                child: Image.network(
                                  userData.imageUrl!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      Text(
                        userData.userName,
                        style: const TextStyle(fontSize: FontSize.large),
                      ),
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
              HeightMargin.small,
              ElevatedButton(
                onPressed: () {
                  context.goNamed(AppRoute.editMyPage.name);
                },
                child: const Text('プロフィール編集ページへ'),
              ),
              HeightMargin.small,
              ElevatedButton(
                onPressed: () {
                  context.goNamed(AppRoute.editMyImagePage.name);
                },
                child: const Text('アイコン編集ページへ'),
              ),
              HeightMargin.small,
              ElevatedButton(
                onPressed: () {
                  //メールアドレスを変更するダイアログを表示する
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('メールアドレス変更'),
                        content: Column(
                          children: [
                            TextField(
                              decoration: const InputDecoration(
                                labelText: 'パスワード',
                              ),
                              controller: passController,
                            ),
                            TextField(
                              decoration: const InputDecoration(
                                labelText: '新しいメールアドレス',
                              ),
                              controller: newEmailController,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('キャンセル'),
                          ),
                          TextButton(
                            onPressed: () async {
                              //ログイン
                              final result = await ref
                                  .read(authControllerProvider.notifier)
                                  .signIn(
                                      email: ref
                                          .read(currentUserControllerProvider)!
                                          .email!,
                                      password: passController.text);
                              if (result != 'success') {
                                if (context.mounted) {
                                  showSnackBar(context, 'パスワードが違います');
                                }
                              }
                              //メールアドレスを変更する
                              final String updateEmailResult = await ref
                                  .read(authControllerProvider.notifier)
                                  .updateEmail(
                                    email: newEmailController.text,
                                  );
                              if (updateEmailResult == 'success') {
                                if (context.mounted) {
                                  passController.clear();
                                  newEmailController.clear();
                                  showSnackBar(context, 'メールアドレスを変更しました');
                                }
                              } else {
                                if (context.mounted) {
                                  showSnackBar(context, updateEmailResult);
                                }
                              }
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('変更'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('メルアド変更'),
              ),
              HeightMargin.small,
              ElevatedButton(
                onPressed: () async {
                  //パスワードリマインダーメールを送信する
                  final result = await ref
                      .read(authControllerProvider.notifier)
                      .resetPassword();
                  if (result == 'success') {
                    if (context.mounted) {
                      showSnackBar(context, 'パスワード再設定メールを送信しました');
                    }
                  } else {
                    if (context.mounted) {
                      showSnackBar(context, result);
                    }
                  }
                },
                child: const Text('パスワード変更'),
              ),
              //自分がいいねしたタスク一覧をリスト表示
              HeightMargin.large,
              ref.watch(watchMyLikesControllerProvider).when(
                data: (List<Like> likeList) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ref
                          .watch(watchTaskControllerProvider(
                              likeList[index].taskId))
                          .when(
                        data: (Task taskData) {
                          return TaskListTile(taskData: taskData);
                        },
                        loading: () {
                          return const SizedBox.shrink();
                        },
                        error: (error, stackTrace) {
                          return const SizedBox.shrink();
                        },
                      );
                    },
                    itemCount: likeList.length,
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
            ],
          ),
        ),
      ),
    );
  }
}
