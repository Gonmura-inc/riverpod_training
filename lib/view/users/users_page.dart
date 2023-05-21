import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/data_models/userdata/userdata.dart';
import 'package:riverpod_training/repo/user/user_repo.dart';

class UsersPage extends ConsumerWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('会員一覧')),
      body: ref.watch(watchUsersProvider).when(
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        error: (e, s) {
          return Center(child: Text(e.toString()));
        },
        data: (List<UserData> users) {
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final UserData user = users[index];
              return ListTile(
                title: Text(user.userName),
                subtitle: Text(user.createdAt.toDate().toString()),
              );
            },
          );
        },
      ),
    );
  }
}
