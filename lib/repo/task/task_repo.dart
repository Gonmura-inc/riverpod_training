import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/config/firebase/firebase_instance_provider.dart';

import 'package:riverpod_training/config/utils/keys/firebase_key.dart';
import 'package:riverpod_training/data_models/task/task.dart';

part 'task_repo.g.dart';

@riverpod
class TaskRepo extends _$TaskRepo {
  @override
  CollectionReference<Task> build() {
    return ref
        .read(firebaseFireStoreInstanceProvider)
        .collection(FirebaseTasksKey.taskCollection)
        .withConverter<Task>(
          fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
          toFirestore: (Task value, _) => value.toJson(),
        );
  }

  //StreamでtaskListを取得
  Stream<List<Task>> watchTasks() {
    return state
        .orderBy(FirebaseTasksKey.createdAt, descending: true)
        .snapshots()
        .map(
      (QuerySnapshot<Task> snapshot) {
        return snapshot.docs.map(
          (QueryDocumentSnapshot<Task> doc) {
            return doc.data();
          },
        ).toList();
      },
    );
  }

  //FutureでtaskListを取得
  Future<List<Task>> getTasks() async {
    final snapshot = await state.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  //taskIDからドキュメント取得
  Future<Task> getTask(String taskId) async {
    final taskDoc = await state.doc(taskId).get();
    return taskDoc.data()!;
  }

  //Streamでドキュメント取得
  Stream<Task> watchTask(String taskId) {
    return state.doc(taskId).snapshots().map(
          (DocumentSnapshot<Task> snapshot) => snapshot.data()!,
        );
  }

  //ドキュメント更新
  Future<void> updateTask(Task updateTaskData) async {
    await state.doc(updateTaskData.taskId).update(updateTaskData.toJson());
  }

  //ドキュメント削除
  Future<void> deleteTask(String taskId) async {
    await state.doc(taskId).delete();
  }

  //ドキュメント追加
  Future<void> addTask(Task addTaskData) async {
    await state.doc(addTaskData.taskId).set(addTaskData);
  }
}

///taskListをstreamで持っているBasicProviderを定義しないと、
///view側から呼べないから作る必要あり
///上記のtaskRepoプロバイダーのstateはあくまでuserFireStoreだからね。
@riverpod
Stream<List<Task>> tasksStream(TasksStreamRef ref) {
  return ref.read(taskRepoProvider.notifier).watchTasks();
}

@riverpod
Stream<Task> watchTask(WatchTaskRef ref, String taskId) {
  return ref.read(taskRepoProvider).doc(taskId).snapshots().map(
        (DocumentSnapshot<Task> snapshot) => snapshot.data()!,
      );
}
