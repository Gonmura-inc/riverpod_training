import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/config/utils/enum/router_enum.dart';
import 'package:riverpod_training/config/utils/margin/width_margin.dart';
import 'package:riverpod_training/data_models/like/like.dart';
import 'package:riverpod_training/data_models/task/task.dart';
import 'package:riverpod_training/data_models/userdata/userdata.dart';
import 'package:riverpod_training/repo/auth/auth_repo.dart';
import 'package:riverpod_training/repo/like/like_repo.dart';
import 'package:riverpod_training/repo/user/user_repo.dart';
import 'package:uuid/uuid.dart';

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
          subtitle: ref.watch(WatchAccountProvider(taskData.userId)).when(
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
        ref.watch(watchLikesProvider(taskData.taskId)).when(
          data: (List<Like> likeList) {
            bool isLiked = false;
            String myLikeId = '';
            for (final Like likeData in likeList) {
              if (likeData.userId == ref.read(authRepoProvider)!.uid) {
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
                          .read(likeRepoProvider(taskData.taskId).notifier)
                          .deleteLike(myLikeId);
                    } else {
                      //いいねをする
                      final Like addLikeData = Like(
                        likeId: const Uuid().v4(),
                        taskId: taskData.taskId,
                        userId: ref.read(authRepoProvider)!.uid,
                        createdAt: Timestamp.now(),
                      );
                      ref
                          .read(likeRepoProvider(taskData.taskId).notifier)
                          .addLike(addLikeData);
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
