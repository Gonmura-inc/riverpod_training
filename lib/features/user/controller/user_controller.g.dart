// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$watchUsersControllerHash() =>
    r'2d06c9adb1fe3f75dc5994fd1b81d50d5dab851a';

/// See also [watchUsersController].
@ProviderFor(watchUsersController)
final watchUsersControllerProvider =
    AutoDisposeStreamProvider<List<UserData>>.internal(
  watchUsersController,
  name: r'watchUsersControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchUsersControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchUsersControllerRef = AutoDisposeStreamProviderRef<List<UserData>>;
String _$watchAccountControllerHash() =>
    r'5caf277783cd1ee13cd8fec95655744c099a7ee3';

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

typedef WatchAccountControllerRef = AutoDisposeStreamProviderRef<UserData?>;

/// See also [watchAccountController].
@ProviderFor(watchAccountController)
const watchAccountControllerProvider = WatchAccountControllerFamily();

/// See also [watchAccountController].
class WatchAccountControllerFamily extends Family<AsyncValue<UserData?>> {
  /// See also [watchAccountController].
  const WatchAccountControllerFamily();

  /// See also [watchAccountController].
  WatchAccountControllerProvider call(
    String userId,
  ) {
    return WatchAccountControllerProvider(
      userId,
    );
  }

  @override
  WatchAccountControllerProvider getProviderOverride(
    covariant WatchAccountControllerProvider provider,
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
  String? get name => r'watchAccountControllerProvider';
}

/// See also [watchAccountController].
class WatchAccountControllerProvider
    extends AutoDisposeStreamProvider<UserData?> {
  /// See also [watchAccountController].
  WatchAccountControllerProvider(
    this.userId,
  ) : super.internal(
          (ref) => watchAccountController(
            ref,
            userId,
          ),
          from: watchAccountControllerProvider,
          name: r'watchAccountControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchAccountControllerHash,
          dependencies: WatchAccountControllerFamily._dependencies,
          allTransitiveDependencies:
              WatchAccountControllerFamily._allTransitiveDependencies,
        );

  final String userId;

  @override
  bool operator ==(Object other) {
    return other is WatchAccountControllerProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$watchMyAccountControllerHash() =>
    r'5de93e0413a848c8f0f29841f19947c608427f4b';

/// See also [watchMyAccountController].
@ProviderFor(watchMyAccountController)
final watchMyAccountControllerProvider =
    AutoDisposeStreamProvider<UserData?>.internal(
  watchMyAccountController,
  name: r'watchMyAccountControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchMyAccountControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchMyAccountControllerRef = AutoDisposeStreamProviderRef<UserData?>;
String _$userControllerHash() => r'b8bd2eda117eb75dfe58ff6c49efed0c3c8a39fb';

/// See also [UserController].
@ProviderFor(UserController)
final userControllerProvider =
    AutoDisposeNotifierProvider<UserController, AsyncValue<dynamic>>.internal(
  UserController.new,
  name: r'userControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserController = AutoDisposeNotifier<AsyncValue<dynamic>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
