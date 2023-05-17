// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tasksStreamHash() => r'0844d0ce3573f118fbe714665c083bfd68ab2127';

///taskListをstreamで持っているBasicProviderを定義しないと、
///view側から呼べないから作る必要あり
///上記のtaskRepoプロバイダーのstateはあくまでuserFireStoreだからね。
///
/// Copied from [tasksStream].
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
String _$taskRepoHash() => r'4fbd3a2daf738d80dde49f81953e12fd1d32125a';

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
