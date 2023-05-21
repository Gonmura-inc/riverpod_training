import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/config/utils/enum/router_enum.dart';
import 'package:riverpod_training/config/utils/fontStyle/font_size.dart';
import 'package:riverpod_training/config/utils/margin/height_margin.dart';
import 'package:riverpod_training/data_models/userdata/userdata.dart';
import 'package:riverpod_training/repo/auth/auth_repo.dart';
import 'package:riverpod_training/repo/user/user_repo.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
        actions: [
          IconButton(
              onPressed: () {
                //ログアウト
                ref.read(authRepoProvider.notifier).signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            HeightMargin.normal,
            ref.watch(watchMyAccountProvider).when(
              data: (UserData? data) {
                if (data == null) {
                  return const SizedBox.shrink();
                }
                return Text(
                  data.userName,
                  style: const TextStyle(fontSize: FontSize.large),
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
            HeightMargin.large,
            ElevatedButton(
              onPressed: () {
                context.goNamed(AppRoute.editMyPage.name, queryParameters: {
                  'userId': ref.read(authRepoProvider)!.uid,
                });
              },
              child: const Text('プロフィール編集ページへ'),
            )
          ],
        ),
      ),
    );
  }
}
