// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$watchUsersHash() => r'18c98a35776b7358a9185b3ee178c5164e350ef3';

/// See also [watchUsers].
@ProviderFor(watchUsers)
final watchUsersProvider = AutoDisposeStreamProvider<List<UserData>>.internal(
  watchUsers,
  name: r'watchUsersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$watchUsersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchUsersRef = AutoDisposeStreamProviderRef<List<UserData>>;
String _$watchAccountHash() => r'd7659bce830f01a404c002dd0be4569189d4fee3';

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

typedef WatchAccountRef = AutoDisposeStreamProviderRef<UserData?>;

/// See also [watchAccount].
@ProviderFor(watchAccount)
const watchAccountProvider = WatchAccountFamily();

/// See also [watchAccount].
class WatchAccountFamily extends Family<AsyncValue<UserData?>> {
  /// See also [watchAccount].
  const WatchAccountFamily();

  /// See also [watchAccount].
  WatchAccountProvider call(
    String userId,
  ) {
    return WatchAccountProvider(
      userId,
    );
  }

  @override
  WatchAccountProvider getProviderOverride(
    covariant WatchAccountProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'watchAccountProvider';
}

/// See also [watchAccount].
class WatchAccountProvider extends AutoDisposeStreamProvider<UserData?> {
  /// See also [watchAccount].
  WatchAccountProvider(
    this.userId,
  ) : super.internal(
          (ref) => watchAccount(
            ref,
            userId,
          ),
          from: watchAccountProvider,
          name: r'watchAccountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchAccountHash,
          dependencies: WatchAccountFamily._dependencies,
          allTransitiveDependencies:
              WatchAccountFamily._allTransitiveDependencies,
        );

  final String userId;

  @override
  bool operator ==(Object other) {
    return other is WatchAccountProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$watchMyAccountHash() => r'fd4b19fcf9a817e3341d748321f8dfe2464a2b95';

/// See also [watchMyAccount].
@ProviderFor(watchMyAccount)
final watchMyAccountProvider = AutoDisposeStreamProvider<UserData?>.internal(
  watchMyAccount,
  name: r'watchMyAccountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchMyAccountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchMyAccountRef = AutoDisposeStreamProviderRef<UserData?>;
String _$userRepoHash() => r'368ab6ebe8c11d111eb3d46044b5d43245aa12b4';

/// See also [UserRepo].
@ProviderFor(UserRepo)
final userRepoProvider = AutoDisposeNotifierProvider<UserRepo,
    CollectionReference<UserData>>.internal(
  UserRepo.new,
  name: r'userRepoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserRepo = AutoDisposeNotifier<CollectionReference<UserData>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
