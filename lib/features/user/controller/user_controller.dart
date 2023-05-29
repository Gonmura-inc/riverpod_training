import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/features/auth/repo/auth_repo.dart';
import 'package:riverpod_training/features/user/data_model/user_data.dart';
import 'package:riverpod_training/features/user/repo/user_repo.dart';
part 'user_controller.g.dart';

@riverpod
class UserController extends _$UserController {
  @override
  AsyncValue build() {
    return const AsyncData(null);
    // return AsyncLoading();
  }

  Future<void> updateUserName(String newUserName, UserData myAccount) async {
    state = const AsyncLoading();
    final UserData updateAccount = myAccount.copyWith(userName: newUserName);
    await ref.read(userRepoProvider.notifier).updateUser(updateAccount);
    state = const AsyncData(null);
  }

  Future<UserData?> getAccount() async {
    state = const AsyncLoading();
    final UserData? userData = await ref
        .read(userRepoProvider.notifier)
        .getAccount(ref.read(authRepoProvider)!.uid);
    state = const AsyncData(null);
    return userData;
  }

  Future<void> updateUserImageUrl(
      UserData myUserData, String downloadUrl) async {
    state = const AsyncLoading();
    final UserData updateUserData = myUserData.copyWith(imageUrl: downloadUrl);
    await ref.read(userRepoProvider.notifier).updateUser(updateUserData);
    state = const AsyncData(null);
  }

  Future<void> createUser() async {
    state = const AsyncLoading();
    UserData addAccount = UserData(
      userId: ref.read(authRepoProvider)!.uid,
      userName: '',
      createdAt: Timestamp.now(),
    );
    await ref.read(userRepoProvider.notifier).createUser(addAccount);
    state = const AsyncData(null);
  }
}

@riverpod
Stream<List<UserData>> watchUsersController(WatchUsersControllerRef ref) {
  return ref.watch(userRepoProvider.notifier).watchUsers();
}

@riverpod
Stream<UserData?> watchAccountController(
    WatchAccountControllerRef ref, String userId) {
  return ref.watch(userRepoProvider.notifier).watchAccount(userId);
}

//自分のユーザードキュメントを監視するプロバイダー
@riverpod
Stream<UserData?> watchMyAccountController(WatchMyAccountControllerRef ref) {
  return ref
      .watch(userRepoProvider.notifier)
      .watchAccount(ref.watch(authRepoProvider)!.uid);
}
