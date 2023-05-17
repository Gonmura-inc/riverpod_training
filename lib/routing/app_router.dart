// private navigators
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_training/view/new_task_screen.dart';
import 'package:riverpod_training/view/tasks_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  tasks,
  newTask,
}

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: '/tasks',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
          path: '/tasks',
          name: AppRoute.tasks.name,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: TasksScreen());
          },
          routes: [
            GoRoute(
              path: 'new_task',
              name: AppRoute.newTask.name,
              pageBuilder: (context, state) {
                return const MaterialPage(
                    fullscreenDialog: true, child: NewTaskScreen());
              },
            ),
          ]),
    ],
  );
}
