import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/config/utils/enum/router_enum.dart';
import 'package:riverpod_training/routing/app_router.dart';

part 'bottom_navi_provider.g.dart';

@riverpod
class BottomNaviSelectedIndex extends _$BottomNaviSelectedIndex {
  @override
  int build() {
    //現在のパス取得
    final String currentPath = ref.read(goRouterProvider).location;
    if (currentPath == AppRoute.tasks.path) {
      return 0;
    } else if (currentPath == AppRoute.users.path) {
      return 1;
    } else if (currentPath == AppRoute.mypage.path) {
      return 2;
    } else {
      return 0;
    }
  }

  void change(int index) {
    state = index;
  }
}
