enum AppRoute {
  auth,
  tasks,
  newTask,
}

extension AppRouteExtention on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.auth:
        return "/auth";
      case AppRoute.tasks:
        return "/tasks";
      case AppRoute.newTask:
        return "newTask";
      default:
        return "/tasks";
    }
  }
}
