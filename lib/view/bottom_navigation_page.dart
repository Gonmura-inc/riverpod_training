import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/config/utils/enum/router_enum.dart';
import 'package:riverpod_training/provider/bottom_navi/bottom_navi_provider.dart';

class BottomNavigationPage extends ConsumerWidget {
  const BottomNavigationPage({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ref.watch(bottomNaviSelectedIndexProvider),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '会員一覧',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'マイページ',
          ),
        ],
        onTap: (int value) {
          ref.read(bottomNaviSelectedIndexProvider.notifier).change(value);
          switch (value) {
            case 0:
              context.goNamed(AppRoute.tasks.name);
              break;
            case 1:
              context.goNamed(AppRoute.users.name);
              break;
            case 2:
              context.goNamed(AppRoute.mypage.name);
              break;
          }
        },
      ),
    );
  }
}
