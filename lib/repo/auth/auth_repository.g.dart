// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authStateChangesHash() => r'32b55faf1eb5e02d7b25d1000f98cf09485d682c';

/// See also [authStateChanges].
@ProviderFor(authStateChanges)
final authStateChangesProvider = AutoDisposeStreamProvider<User?>.internal(
  authStateChanges,
  name: r'authStateChangesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthStateChangesRef = AutoDisposeStreamProviderRef<User?>;
String _$authRepoHash() => r'eb8d68e773bf97cd6c5c019d1f324ad175bd9a9c';

/// See also [AuthRepo].
@ProviderFor(AuthRepo)
final authRepoProvider = NotifierProvider<AuthRepo, User?>.internal(
  AuthRepo.new,
  name: r'authRepoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthRepo = Notifier<User?>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
