import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/config/utils/enum/router_enum.dart';
import 'package:riverpod_training/config/utils/margin/width_margin.dart';
import 'package:riverpod_training/features/auth/contoller/auth_controller.dart';
import 'package:riverpod_training/features/like/controller/like_controller.dart';
import 'package:riverpod_training/features/like/data_model/like.dart';
import 'package:riverpod_training/features/task/data_model/task.dart';
import 'package:riverpod_training/features/user/controller/user_controller.dart';
import 'package:riverpod_training/features/user/data_model/userdata.dart';

class TaskListTile extends ConsumerWidget {
  const TaskListTile({
    super.key,
    required this.taskData,
  });

  final Task taskData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            context.goNamed(
              AppRoute.editTask.name,
              queryParameters: {
                "taskId": taskData.taskId,
              },
            );
          },
          title: Text(taskData.title),
          subtitle:
              ref.watch(watchAccountControllerProvider(taskData.userId)).when(
            data: (UserData? postAccount) {
              if (postAccount == null) {
                return const Text("エラー");
              }
              return Text(postAccount.userName);
            },
            error: (error, stackTrace) {
              return const Text("エラー");
            },
            loading: () {
              return const Text("読み込み中");
            },
          ),
          trailing:
              Text(taskData.createdAt.toDate().toString().substring(0, 16)),
        ),
        ref.watch(watchLikesControllerProvider(taskData.taskId)).when(
          data: (List<Like> likeList) {
            bool isLiked = false;
            String myLikeId = '';
            for (final Like likeData in likeList) {
              if (likeData.userId == ref.read(authControllerProvider)!.uid) {
                isLiked = true;
                myLikeId = likeData.likeId;
                break;
              }
            }
            return Row(
              children: [
                WidthMargin.small,
                IconButton(
                  onPressed: () {
                    if (isLiked) {
                      //いいねを取り消す
                      ref
                          .read(likeControllerProvider.notifier)
                          .deleteLike(taskData.taskId, myLikeId);
                    } else {
                      ref
                          .read(likeControllerProvider.notifier)
                          .addLike(taskData.taskId);
                    }
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: isLiked ? Colors.red : Colors.grey,
                  ),
                ),
                const Text('いいね数'),
                WidthMargin.small,
                Text('${likeList.length}'),
              ],
            );
          },
          error: (error, stackTrace) {
            return const Text('エラー');
          },
          loading: () {
            return const Text('読み込み中');
          },
        ),
      ],
    );
  }
}
