import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/config/firebase/firebase_provider.dart';
import 'package:riverpod_training/config/utils/keys/firebase_key.dart';
import 'package:riverpod_training/data_models/task/task.dart';

part 'tasks_repository.g.dart';

@riverpod
class TaskRepo extends _$TaskRepo {
  ///このproviderのstateは
  ///上記で書いたCollectionReferenceです
  ///つまりstate.doc()とかstate.add()とかでメソッドかけます
  @override
  CollectionReference<Task> build() {
    return ref
        .read(firestoreProvider)
        .collection(FirebaseKey.taskCollection)
        .withConverter<Task>(
          fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
          toFirestore: (Task value, _) => value.toJson(),
        );
  }

  Stream<List<Task>> watchTasks() {
    return state.orderBy('createdAt', descending: true).snapshots().map(
      (snapshot) {
        return snapshot.docs.map(
          (doc) {
            return doc.data();
          },
        ).toList();
      },
    );
  }

  Future<void> addTask(Task addTaskData) async {
    await state.doc(addTaskData.taskId).set(addTaskData);
  }
}

///taskListをstreamで持っているBasicProviderを定義しないと、
///view側から呼べないから作る必要あり
///上記のtaskRepoプロバイダーのstateはあくまでuserFireStoreだからね。
@riverpod
Stream<List<Task>> tasksStream(TasksStreamRef ref) {
  final repository = ref.read(taskRepoProvider.notifier);
  return repository.watchTasks();
}
