import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/config/utils/enum/router_enum.dart';
import 'package:riverpod_training/routing/app_router.dart';

class TaskTabPage extends HookConsumerWidget {
  const TaskTabPage({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);
    final tabs = useState([
      const Tab(text: '一括読み込み'),
      const Tab(text: '5件ずつ読み込み'),
    ]);
    final tabController = useTabController(initialLength: tabs.value.length);
    tabController.addListener(
      () {
        if (tabController.index == 0) {
          context.goNamed(AppRoute.tasks.name);
        } else if (tabController.index == 1) {
          context.goNamed(AppRoute.fiveTasks.name);
        }
      },
    );
    useEffect(() {
      //現在のパス取得
      final String currentPath = ref.read(goRouterProvider).location;
      if (currentPath == AppRoute.tasks.path) {
        selectedIndex.value = 0;
      } else if (currentPath == AppRoute.fiveTasks.path) {
        selectedIndex.value = 1;
      } else {
        selectedIndex.value = 0;
      }
      return null;
    }, [
      /// ここに変更を監視したい変数を入れる
      ref.read(goRouterProvider).location,
    ]);
    return DefaultTabController(
      initialIndex: selectedIndex.value,
      length: tabs.value.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('タスク一覧'),
          bottom: TabBar(
            controller: tabController,
            tabs: tabs.value,
          ),
        ),
        body: child,
      ),
    );
  }
}
