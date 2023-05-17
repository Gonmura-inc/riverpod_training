enum AppRoute {
  tasks,
  newTask,
}

extension AppRouteExtention on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.tasks:
        return "/tasks";
      case AppRoute.newTask:
        return "newTask";
      default:
        return "/tasks";
    }
  }
}
