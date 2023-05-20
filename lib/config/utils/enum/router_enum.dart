enum AppRoute {
  login,
  tasks,
  newTask,
  auth,
  editTask,
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
      case AppRoute.editTask:
        return "editTask";
      default:
        return "/tasks";
    }
  }
}
