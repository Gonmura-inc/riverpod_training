import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/config/utils/fontStyle/font_size.dart';
import 'package:riverpod_training/config/utils/margin/height_margin.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            HeightMargin.normal,
            const Text(
              'ここに自分の名前',
              style: TextStyle(fontSize: FontSize.large),
            ),
            HeightMargin.large,
            ElevatedButton(onPressed: () {}, child: const Text('プロフィール編集ページへ'))
          ],
        ),
      ),
    );
  }
}
