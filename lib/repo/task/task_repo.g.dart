// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tasksStreamHash() => r'3e136375a3a74421ce6c0570124a76d79f01a194';

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
String _$watchTaskHash() => r'c6b6ead2dd40788e46409f0c79279d747aa119a2';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef WatchTaskRef = AutoDisposeStreamProviderRef<Task>;

/// See also [watchTask].
@ProviderFor(watchTask)
const watchTaskProvider = WatchTaskFamily();

/// See also [watchTask].
class WatchTaskFamily extends Family<AsyncValue<Task>> {
  /// See also [watchTask].
  const WatchTaskFamily();

  /// See also [watchTask].
  WatchTaskProvider call(
    String taskId,
  ) {
    return WatchTaskProvider(
      taskId,
    );
  }

  @override
  WatchTaskProvider getProviderOverride(
    covariant WatchTaskProvider provider,
  ) {
    return call(
      provider.taskId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'watchTaskProvider';
}

/// See also [watchTask].
class WatchTaskProvider extends AutoDisposeStreamProvider<Task> {
  /// See also [watchTask].
  WatchTaskProvider(
    this.taskId,
  ) : super.internal(
          (ref) => watchTask(
            ref,
            taskId,
          ),
          from: watchTaskProvider,
          name: r'watchTaskProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchTaskHash,
          dependencies: WatchTaskFamily._dependencies,
          allTransitiveDependencies: WatchTaskFamily._allTransitiveDependencies,
        );

  final String taskId;

  @override
  bool operator ==(Object other) {
    return other is WatchTaskProvider && other.taskId == taskId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$taskRepoHash() => r'6de10e18801c9c0f113ae9d29fe8b74a82d877c9';

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
