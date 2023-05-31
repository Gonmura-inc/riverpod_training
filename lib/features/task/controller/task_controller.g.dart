// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTaskControllerHash() => r'ab570d536b39a0e948d9875ab58a4f92a6d1c2ab';

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

typedef GetTaskControllerRef = AutoDisposeFutureProviderRef<Task>;

/// See also [getTaskController].
@ProviderFor(getTaskController)
const getTaskControllerProvider = GetTaskControllerFamily();

/// See also [getTaskController].
class GetTaskControllerFamily extends Family<AsyncValue<Task>> {
  /// See also [getTaskController].
  const GetTaskControllerFamily();

  /// See also [getTaskController].
  GetTaskControllerProvider call(
    String taskId,
  ) {
    return GetTaskControllerProvider(
      taskId,
    );
  }

  @override
  GetTaskControllerProvider getProviderOverride(
    covariant GetTaskControllerProvider provider,
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
  String? get name => r'getTaskControllerProvider';
}

/// See also [getTaskController].
class GetTaskControllerProvider extends AutoDisposeFutureProvider<Task> {
  /// See also [getTaskController].
  GetTaskControllerProvider(
    this.taskId,
  ) : super.internal(
          (ref) => getTaskController(
            ref,
            taskId,
          ),
          from: getTaskControllerProvider,
          name: r'getTaskControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTaskControllerHash,
          dependencies: GetTaskControllerFamily._dependencies,
          allTransitiveDependencies:
              GetTaskControllerFamily._allTransitiveDependencies,
        );

  final String taskId;

  @override
  bool operator ==(Object other) {
    return other is GetTaskControllerProvider && other.taskId == taskId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$tasksStreamControllerHash() =>
    r'a0338d78a72127390b1d27bde074bb5e31c5f007';

/// See also [tasksStreamController].
@ProviderFor(tasksStreamController)
final tasksStreamControllerProvider =
    AutoDisposeStreamProvider<List<Task>>.internal(
  tasksStreamController,
  name: r'tasksStreamControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tasksStreamControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TasksStreamControllerRef = AutoDisposeStreamProviderRef<List<Task>>;
String _$watchMyTasksControllerHash() =>
    r'4aa9a1ea995d1a09d94ca94d65e9ff0e1cfdbc12';

/// See also [watchMyTasksController].
@ProviderFor(watchMyTasksController)
final watchMyTasksControllerProvider =
    AutoDisposeStreamProvider<List<Task>>.internal(
  watchMyTasksController,
  name: r'watchMyTasksControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchMyTasksControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchMyTasksControllerRef = AutoDisposeStreamProviderRef<List<Task>>;
String _$watchTaskControllerHash() =>
    r'0b8703f9cf8463484bcf2c5641ca12adb5908ccc';
typedef WatchTaskControllerRef = AutoDisposeStreamProviderRef<Task>;

/// See also [watchTaskController].
@ProviderFor(watchTaskController)
const watchTaskControllerProvider = WatchTaskControllerFamily();

/// See also [watchTaskController].
class WatchTaskControllerFamily extends Family<AsyncValue<Task>> {
  /// See also [watchTaskController].
  const WatchTaskControllerFamily();

  /// See also [watchTaskController].
  WatchTaskControllerProvider call(
    String taskId,
  ) {
    return WatchTaskControllerProvider(
      taskId,
    );
  }

  @override
  WatchTaskControllerProvider getProviderOverride(
    covariant WatchTaskControllerProvider provider,
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
  String? get name => r'watchTaskControllerProvider';
}

/// See also [watchTaskController].
class WatchTaskControllerProvider extends AutoDisposeStreamProvider<Task> {
  /// See also [watchTaskController].
  WatchTaskControllerProvider(
    this.taskId,
  ) : super.internal(
          (ref) => watchTaskController(
            ref,
            taskId,
          ),
          from: watchTaskControllerProvider,
          name: r'watchTaskControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchTaskControllerHash,
          dependencies: WatchTaskControllerFamily._dependencies,
          allTransitiveDependencies:
              WatchTaskControllerFamily._allTransitiveDependencies,
        );

  final String taskId;

  @override
  bool operator ==(Object other) {
    return other is WatchTaskControllerProvider && other.taskId == taskId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$taskControllerHash() => r'a7a2e4245862c48a0556ea0a8b4433f5979cbf07';

/// See also [TaskController].
@ProviderFor(TaskController)
final taskControllerProvider =
    AutoDisposeNotifierProvider<TaskController, AsyncValue<dynamic>>.internal(
  TaskController.new,
  name: r'taskControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$taskControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TaskController = AutoDisposeNotifier<AsyncValue<dynamic>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
