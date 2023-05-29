import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/features/auth/repo/auth_repo.dart';

part 'current_user_controller.g.dart';

@riverpod
class CurrentUserController extends _$CurrentUserController {
  @override
  User? build() {
    return ref.watch(authRepoProvider);
  }
}
