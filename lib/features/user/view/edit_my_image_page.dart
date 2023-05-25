import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:riverpod_training/config/utils/fontStyle/font_size.dart';
import 'package:riverpod_training/config/utils/margin/height_margin.dart';
import 'package:riverpod_training/features/user/data_model/userdata.dart';
import 'package:riverpod_training/functions/show_snack_bar.dart';
import 'package:riverpod_training/features/auth/repo/auth_repo.dart';
import 'package:riverpod_training/features/user/repo/storage_repo.dart';
import 'package:riverpod_training/features/user/repo/user_repo.dart';

class EditMyImagePage extends HookConsumerWidget {
  const EditMyImagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<Uint8List?> uint8list = useState(null);
    //アイコンを変更できるページ
    return Scaffold(
      appBar: AppBar(
        title: const Text('アイコン変更'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///ログインユーザーdocumentのimageUrlフィールドが
            ///nullもしくは空白文字列じゃなかったら
            ///アイコン表示
            ///空白だったら、デフォルトアイコン表示
            ref.watch(watchMyAccountProvider).when(
              data: (UserData? userData) {
                if (userData == null) {
                  return const Text(
                    'エラーが発生しました。再度お試しください。',
                    style: TextStyle(fontSize: FontSize.large),
                  );
                }
                if (userData.imageUrl == null || userData.imageUrl == '') {
                  return InkWell(
                    onTap: () async {
                      uint8list.value = await ImagePickerWeb.getImageAsBytes();
                    },
                    child: const Icon(
                      Icons.person,
                      size: 100,
                    ),
                  );
                }
                return InkWell(
                  onTap: () async {
                    uint8list.value = await ImagePickerWeb.getImageAsBytes();
                  },
                  child: ClipOval(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.network(
                        userData.imageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              error: (error, stackTrace) {
                return const Text(
                  'エラーが発生しました。再度お試しください。',
                  style: TextStyle(fontSize: FontSize.large),
                );
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
            ),

            ///アイコンを削除するボタン
            ElevatedButton(
              onPressed: () async {
                //アイコンを変更したら、ユーザーのdocumentのimageUrlフィールドを更新
                await _deleteIcon(ref, context);
              },
              child: const Text('削除'),
            ),
            HeightMargin.large,

            ///アイコンを変更するボタン
            ElevatedButton(
              onPressed: () async {
                if (uint8list.value == null) {
                  showSnackBar(context, '画像が選択されていません。');
                  return;
                }
                //アイコンを変更する処理
                await _updateIcon(ref, uint8list, context);
              },
              child: const Text('アイコンを変更する'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateIcon(
    WidgetRef ref,
    ValueNotifier<Uint8List?> uint8list,
    BuildContext context,
  ) async {
    final downloadUrl =
        await ref.read(storageRepoProvider.notifier).uploadImageAndGetUrl(
              ref.read(authRepoProvider)!.uid,
              uint8list.value!,
            );
    //アイコンを変更したら、ユーザーのdocumentのimageUrlフィールドを更新
    if (context.mounted) {
      await _updateImageUrl(ref, context, downloadUrl);
    }

    if (context.mounted) {
      showSnackBar(context, '変更完了');
    }
    return;
  }

  Future<void> _deleteIcon(
    WidgetRef ref,
    BuildContext context,
  ) async {
    await _updateImageUrl(ref, context, '');
    //storageの削除
    final String myUserId = ref.read(authRepoProvider)!.uid;
    await ref.read(storageRepoProvider.notifier).deleteImage(myUserId);
    if (context.mounted) {
      showSnackBar(context, '削除完了');
    }

    return;
  }

  Future<void> _updateImageUrl(
      WidgetRef ref, BuildContext context, String downloadUrl) async {
    final String myUserId = ref.read(authRepoProvider)!.uid;
    final UserData? myUserData =
        await ref.read(userRepoProvider.notifier).getAccount(myUserId);
    if (myUserData == null) {
      if (context.mounted) {
        showSnackBar(context, 'エラーが発生しました');
      }
      return;
    }
    final UserData updateUserData = myUserData.copyWith(imageUrl: downloadUrl);
    await ref.read(userRepoProvider.notifier).updateUser(updateUserData);
    return;
  }
}
