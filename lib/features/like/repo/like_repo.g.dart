// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$likeRepoHash() => r'1b237d748665db661f31571142f710f4682cdbe8';

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

abstract class _$LikeRepo
    extends BuildlessAutoDisposeNotifier<CollectionReference<Like>> {
  late final String taskId;

  CollectionReference<Like> build(
    String taskId,
  );
}

/// See also [LikeRepo].
@ProviderFor(LikeRepo)
const likeRepoProvider = LikeRepoFamily();

/// See also [LikeRepo].
class LikeRepoFamily extends Family<CollectionReference<Like>> {
  /// See also [LikeRepo].
  const LikeRepoFamily();

  /// See also [LikeRepo].
  LikeRepoProvider call(
    String taskId,
  ) {
    return LikeRepoProvider(
      taskId,
    );
  }

  @override
  LikeRepoProvider getProviderOverride(
    covariant LikeRepoProvider provider,
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
  String? get name => r'likeRepoProvider';
}

/// See also [LikeRepo].
class LikeRepoProvider extends AutoDisposeNotifierProviderImpl<LikeRepo,
    CollectionReference<Like>> {
  /// See also [LikeRepo].
  LikeRepoProvider(
    this.taskId,
  ) : super.internal(
          () => LikeRepo()..taskId = taskId,
          from: likeRepoProvider,
          name: r'likeRepoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$likeRepoHash,
          dependencies: LikeRepoFamily._dependencies,
          allTransitiveDependencies: LikeRepoFamily._allTransitiveDependencies,
        );

  final String taskId;

  @override
  bool operator ==(Object other) {
    return other is LikeRepoProvider && other.taskId == taskId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskId.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  CollectionReference<Like> runNotifierBuild(
    covariant LikeRepo notifier,
  ) {
    return notifier.build(
      taskId,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
