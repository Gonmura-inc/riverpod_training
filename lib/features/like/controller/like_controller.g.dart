// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$watchLikesControllerHash() =>
    r'36742739c8a5acfe757a3490e183488c2982058c';

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

typedef WatchLikesControllerRef = AutoDisposeStreamProviderRef<List<Like>>;

/// See also [watchLikesController].
@ProviderFor(watchLikesController)
const watchLikesControllerProvider = WatchLikesControllerFamily();

/// See also [watchLikesController].
class WatchLikesControllerFamily extends Family<AsyncValue<List<Like>>> {
  /// See also [watchLikesController].
  const WatchLikesControllerFamily();

  /// See also [watchLikesController].
  WatchLikesControllerProvider call(
    String taskId,
  ) {
    return WatchLikesControllerProvider(
      taskId,
    );
  }

  @override
  WatchLikesControllerProvider getProviderOverride(
    covariant WatchLikesControllerProvider provider,
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
  String? get name => r'watchLikesControllerProvider';
}

/// See also [watchLikesController].
class WatchLikesControllerProvider
    extends AutoDisposeStreamProvider<List<Like>> {
  /// See also [watchLikesController].
  WatchLikesControllerProvider(
    this.taskId,
  ) : super.internal(
          (ref) => watchLikesController(
            ref,
            taskId,
          ),
          from: watchLikesControllerProvider,
          name: r'watchLikesControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchLikesControllerHash,
          dependencies: WatchLikesControllerFamily._dependencies,
          allTransitiveDependencies:
              WatchLikesControllerFamily._allTransitiveDependencies,
        );

  final String taskId;

  @override
  bool operator ==(Object other) {
    return other is WatchLikesControllerProvider && other.taskId == taskId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$watchMyLikesControllerHash() =>
    r'479639e711e897da1be1d1663ae20487857c3fe3';

/// See also [watchMyLikesController].
@ProviderFor(watchMyLikesController)
final watchMyLikesControllerProvider =
    AutoDisposeStreamProvider<List<Like>>.internal(
  watchMyLikesController,
  name: r'watchMyLikesControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchMyLikesControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchMyLikesControllerRef = AutoDisposeStreamProviderRef<List<Like>>;
String _$likeControllerHash() => r'539842fc834bf1a01fab3f1fc6cb135924385ae8';

/// See also [LikeController].
@ProviderFor(LikeController)
final likeControllerProvider =
    AutoDisposeNotifierProvider<LikeController, dynamic>.internal(
  LikeController.new,
  name: r'likeControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$likeControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LikeController = AutoDisposeNotifier<dynamic>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
