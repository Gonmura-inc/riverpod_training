import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/features/auth/repo/auth_repo.dart';
import 'package:riverpod_training/features/user/data_model/userdata.dart';
import 'package:riverpod_training/features/user/repo/user_repo.dart';
part 'user_controller.g.dart';

@riverpod
class UserController extends _$UserController {
  @override
  build() {}

  Future<void> updateUserName(String newUserName, UserData myAccount) async {
    final UserData updateAccount = myAccount.copyWith(userName: newUserName);
    await ref.read(userRepoProvider.notifier).updateUser(updateAccount);
  }

  Future<UserData?> getAccount() async {
    return await ref
        .read(userRepoProvider.notifier)
        .getAccount(ref.read(authRepoProvider)!.uid);
  }

  Future<void> updateUserImageUrl(
      UserData myUserData, String downloadUrl) async {
    final UserData updateUserData = myUserData.copyWith(imageUrl: downloadUrl);
    await ref.read(userRepoProvider.notifier).updateUser(updateUserData);
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
