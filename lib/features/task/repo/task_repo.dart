import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/config/firebase/firebase_instance_provider.dart';

import 'package:riverpod_training/config/utils/keys/firebase_key.dart';
import 'package:riverpod_training/features/auth/repo/auth_repo.dart';
import 'package:riverpod_training/features/task/data_model/task.dart';

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

  //自分のタスクを絞り込む
  //Streamでドキュメント取得
  Stream<List<Task>> watchMyTasks() {
    return state
        .where(FirebaseTasksKey.userId,
            isEqualTo: ref.read(authRepoProvider)!.uid)
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

  //Streamで5件ずつtaskListを取得
  Stream<List<Task>> watchFiveTasks(int limit) {
    return state
        .orderBy(FirebaseTasksKey.createdAt, descending: true)
        .limit(limit)
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
}
///Future(get)
///リアルタイム監視できない
///30件ずつとる
///30,30,30,30,30
///1~30,31~60,61~90,91~120,121~150
///30,60,90,120,150
///150件目にたどり着くまでに150回の読み取りをしている
///
///Stream(snapshot)
///リアルタイム監視
///30,60,90,120,150
///1~30,1~60,1~90,1~120,1~150
///30,90,180,300,450
///150件目にたどり着くまでに450回の読み取りをしている
///50,100,150
///50,150,300
///150件目にたどり着くまでに300回の読み取りをしている