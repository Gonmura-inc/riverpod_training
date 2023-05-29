import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:riverpod_training/config/utils/fontStyle/font_size.dart';
import 'package:riverpod_training/config/utils/margin/height_margin.dart';
import 'package:riverpod_training/features/user/controller/storage_controller.dart';
import 'package:riverpod_training/features/user/controller/user_controller.dart';
import 'package:riverpod_training/features/user/data_model/user_data.dart';
import 'package:riverpod_training/functions/show_snack_bar.dart';

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
        child: ref.watch(watchMyAccountControllerProvider).when(
          data: (UserData? userData) {
            if (userData == null) {
              return const Text(
                'エラーが発生しました。再度お試しください。',
                style: TextStyle(fontSize: FontSize.large),
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (userData.imageUrl == null || userData.imageUrl == '')
                  InkWell(
                    onTap: () async {
                      uint8list.value = await ImagePickerWeb.getImageAsBytes();
                    },
                    child: const Icon(
                      Icons.person,
                      size: 100,
                    ),
                  )
                else
                  InkWell(
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
                  ),

                ///アイコンを削除するボタン
                ref.watch(storageControllerProvider).when(
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                  error: (error, stackTrace) {
                    return const Text(
                      'エラーが発生しました。再度お試しください。',
                      style: TextStyle(fontSize: FontSize.large),
                    );
                  },
                  data: (data) {
                    return Column(
                      children: [
                        if (userData.imageUrl != null &&
                            userData.imageUrl != '')
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
                    );
                  },
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
            return const Center(child: CircularProgressIndicator());
          },
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
        await ref.read(storageControllerProvider.notifier).uploadImageAndGetUrl(
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
    await ref.read(storageControllerProvider.notifier).deleteImage();
    if (context.mounted) {
      showSnackBar(context, '削除完了');
    }
    return;
  }

  Future<void> _updateImageUrl(
      WidgetRef ref, BuildContext context, String downloadUrl) async {
    final UserData? myUserData =
        await ref.read(userControllerProvider.notifier).getAccount();
    if (myUserData == null) {
      if (context.mounted) {
        showSnackBar(context, 'エラーが発生しました');
      }
      return;
    }
    await ref
        .read(userControllerProvider.notifier)
        .updateUserImageUrl(myUserData, downloadUrl);
    return;
  }
}
