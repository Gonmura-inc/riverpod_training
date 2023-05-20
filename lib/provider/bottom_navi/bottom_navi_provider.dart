import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/config/utils/enum/router_enum.dart';

part 'bottom_navi_provider.g.dart';

@riverpod
class BottomNaviSelectedIndex extends _$BottomNaviSelectedIndex {
  @override
  int build() {
    return 0;
  }

  void change(int index) {
    state = index;
  }

  void pathCheck(context) {
    final String currentPath = GoRouterState.of(context).location;
    if (currentPath == AppRoute.tasks.path) {
      state = 0;
    } else if (currentPath == AppRoute.mypage.path) {
      state = 1;
    }
  }
}
