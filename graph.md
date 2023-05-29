Analyzing /Users/yoshidamitsuteru/workspace/3.yoshida-test/riverpod_training ...
flowchart TB
  subgraph Arrows
    direction LR
    start1[ ] -..->|read| stop1[ ]
    style start1 height:0px;
    style stop1 height:0px;
    start2[ ] --->|listen| stop2[ ]
    style start2 height:0px;
    style stop2 height:0px; 
    start3[ ] ===>|watch| stop3[ ]
    style start3 height:0px;
    style stop3 height:0px; 
  end

  subgraph Type
    direction TB
    ConsumerWidget((widget));
    Provider[[provider]];
  end
  AuthPage((AuthPage));
  authControllerProvider -.-> AuthPage;
  authControllerProvider -.-> AuthPage;
  userControllerProvider -.-> AuthPage;
  BottomNavigationPage((BottomNavigationPage));
  goRouterProvider ==> BottomNavigationPage;
  goRouterProvider -.-> BottomNavigationPage;
  EditMyUserPage((EditMyUserPage));
  watchMyAccountControllerProvider ==> EditMyUserPage;
  userControllerProvider ==> EditMyUserPage;
  userControllerProvider -.-> EditMyUserPage;
  EditMyImagePage((EditMyImagePage));
  watchMyAccountControllerProvider ==> EditMyImagePage;
  storageControllerProvider ==> EditMyImagePage;
  storageControllerProvider -.-> EditMyImagePage;
  storageControllerProvider -.-> EditMyImagePage;
  userControllerProvider -.-> EditMyImagePage;
  userControllerProvider -.-> EditMyImagePage;
  UsersPage((UsersPage));
  watchUsersControllerProvider ==> UsersPage;
  MyPage((MyPage));
  watchMyAccountControllerProvider ==> MyPage;
  watchMyTasksControllerProvider ==> MyPage;
  watchMyLikesControllerProvider ==> MyPage;
  watchTaskControllerProvider ==> MyPage;
  authControllerProvider -.-> MyPage;
  authControllerProvider -.-> MyPage;
  currentUserControllerProvider -.-> MyPage;
  authControllerProvider -.-> MyPage;
  authControllerProvider -.-> MyPage;
  TasksScreen((TasksScreen));
  watchMyTasksControllerProvider ==> TasksScreen;
  watchMyTasksControllerProvider ==> TasksScreen;
  tasksStreamControllerProvider ==> TasksScreen;
  taskListProvider ==> TasksScreen;
  taskListProvider -.-> TasksScreen;
  AddOrEditTaskPage((AddOrEditTaskPage));
  getTaskControllerProvider ==> AddOrEditTaskPage;
  taskControllerProvider -.-> AddOrEditTaskPage;
  taskControllerProvider -.-> AddOrEditTaskPage;
  MyApp((MyApp));
  goRouterProvider ==> MyApp;
  TaskListTile((TaskListTile));
  watchAccountControllerProvider ==> TaskListTile;
  watchLikesControllerProvider ==> TaskListTile;
  likeControllerProvider -.-> TaskListTile;
  likeControllerProvider -.-> TaskListTile;
  likeControllerProvider -.-> TaskListTile;
  likeControllerProvider -.-> TaskListTile;
  taskControllerProvider -.-> TaskListTile;
  watchLikesControllerProvider[[watchLikesControllerProvider]];
  likeRepoProvider -.-> watchLikesControllerProvider;
  likeRepoProvider[[likeRepoProvider]];
  firebaseFireStoreInstanceProvider -.-> likeRepoProvider;
  watchMyLikesControllerProvider[[watchMyLikesControllerProvider]];
  firebaseFireStoreInstanceProvider -.-> watchMyLikesControllerProvider;
  authRepoProvider -.-> watchMyLikesControllerProvider;
  firebaseFireStoreInstanceProvider[[firebaseFireStoreInstanceProvider]];
  authRepoProvider[[authRepoProvider]];
  firebaseAuthInstanceProvider ==> authRepoProvider;
  currentUserControllerProvider[[currentUserControllerProvider]];
  authRepoProvider ==> currentUserControllerProvider;
  authControllerProvider[[authControllerProvider]];
  userControllerProvider[[userControllerProvider]];
  firebaseAuthInstanceProvider[[firebaseAuthInstanceProvider]];
  goRouterProvider[[goRouterProvider]];
  authRepoProvider ==> goRouterProvider;
  authRepoProvider -.-> goRouterProvider;
  watchUsersControllerProvider[[watchUsersControllerProvider]];
  userRepoProvider ==> watchUsersControllerProvider;
  userRepoProvider[[userRepoProvider]];
  firebaseFireStoreInstanceProvider -.-> userRepoProvider;
  watchAccountControllerProvider[[watchAccountControllerProvider]];
  userRepoProvider ==> watchAccountControllerProvider;
  watchMyAccountControllerProvider[[watchMyAccountControllerProvider]];
  userRepoProvider ==> watchMyAccountControllerProvider;
  authRepoProvider ==> watchMyAccountControllerProvider;
  storageControllerProvider[[storageControllerProvider]];
  watchMyTasksControllerProvider[[watchMyTasksControllerProvider]];
  taskRepoProvider -.-> watchMyTasksControllerProvider;
  watchTaskControllerProvider[[watchTaskControllerProvider]];
  taskRepoProvider -.-> watchTaskControllerProvider;
  storageRepoProvider[[storageRepoProvider]];
  firebaseStorageInstanceProvider -.-> storageRepoProvider;
  firebaseStorageInstanceProvider[[firebaseStorageInstanceProvider]];
  getTaskControllerProvider[[getTaskControllerProvider]];
  taskRepoProvider -.-> getTaskControllerProvider;
  taskRepoProvider[[taskRepoProvider]];
  firebaseFireStoreInstanceProvider -.-> taskRepoProvider;
  tasksStreamControllerProvider[[tasksStreamControllerProvider]];
  taskRepoProvider -.-> tasksStreamControllerProvider;
  taskListProvider[[taskListProvider]];
  taskRepoProvider -.-> taskListProvider;
  taskControllerProvider[[taskControllerProvider]];
  likeControllerProvider[[likeControllerProvider]];
