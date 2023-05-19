enum AppRoute {
  login,
  tasks,
  newTask,
}

extension AppRouteExtention on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.login:
        return "/login";
      case AppRoute.tasks:
        return "/tasks";
      case AppRoute.newTask:
        return "newTask";
      default:
        return "/tasks";
    }
  }
}
