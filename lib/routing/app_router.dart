// private navigators
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_training/config/utils/enum/router_enum.dart';
import 'package:riverpod_training/view/auth_page.dart';
import 'package:riverpod_training/view/new_task_page.dart';
import 'package:riverpod_training/view/tasks_page.dart';
// ignore: depend_on_referenced_packages
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: AppRoute.tasks.path,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoute.auth.path,
        name: AppRoute.auth.name,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: AuthPage());
        },
      ),
      GoRoute(
        path: AppRoute.tasks.path,
        name: AppRoute.tasks.name,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: TasksScreen());
        },
        routes: [
          GoRoute(
            path: AppRoute.newTask.path,
            name: AppRoute.newTask.name,
            pageBuilder: (context, state) {
              return const MaterialPage(
                  fullscreenDialog: true, child: NewTaskScreen());
            },
          ),
        ],
      ),
    ],
  );
}
