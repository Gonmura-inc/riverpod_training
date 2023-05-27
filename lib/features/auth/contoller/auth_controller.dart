import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/features/auth/repo/auth_repo.dart';
part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  User? build() {
    return ref.watch(authRepoProvider);
  }

  Future<void> signOut() async {
    await ref.read(authRepoProvider.notifier).signOut();
  }

  Future<String> signIn(
      {required String email, required String password}) async {
    return await ref
        .read(authRepoProvider.notifier)
        .signIn(email: email, password: password);
  }

  Future<String> updateEmail({required String email}) async {
    return await ref.read(authRepoProvider.notifier).updateEmail(email: email);
  }

  Future<String> resetPassword() async {
    return await ref.read(authRepoProvider.notifier).resetPassword();
  }

  Future<String> createUser(
      {required String email, required String password}) async {
    return await ref
        .read(authRepoProvider.notifier)
        .createUser(email: email, password: password);
  }
}
