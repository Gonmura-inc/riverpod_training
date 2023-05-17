// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userFirestoreHash() => r'a7534349ce7eef4832552d292249d7aa9268c343';

/// See also [userFirestore].
@ProviderFor(userFirestore)
final userFirestoreProvider =
    AutoDisposeProvider<CollectionReference<Task>>.internal(
  userFirestore,
  name: r'userFirestoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userFirestoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserFirestoreRef = AutoDisposeProviderRef<CollectionReference<Task>>;
String _$tasksStreamHash() => r'0844d0ce3573f118fbe714665c083bfd68ab2127';

/// See also [tasksStream].
@ProviderFor(tasksStream)
final tasksStreamProvider = AutoDisposeStreamProvider<List<Task>>.internal(
  tasksStream,
  name: r'tasksStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tasksStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TasksStreamRef = AutoDisposeStreamProviderRef<List<Task>>;
String _$taskRepoHash() => r'6b085ae10bc63573d614f4fbefdb168558b4fec8';

/// See also [TaskRepo].
@ProviderFor(TaskRepo)
final taskRepoProvider =
    AutoDisposeNotifierProvider<TaskRepo, CollectionReference<Task>>.internal(
  TaskRepo.new,
  name: r'taskRepoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$taskRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TaskRepo = AutoDisposeNotifier<CollectionReference<Task>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
