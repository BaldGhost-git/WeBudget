// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userRepositoryHash() => r'a2dda760a427327e23dc6dcf605ca3ce9e9e8352';

/// See also [userRepository].
@ProviderFor(userRepository)
final userRepositoryProvider = AutoDisposeProvider<UserRepository>.internal(
  userRepository,
  name: r'userRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserRepositoryRef = AutoDisposeProviderRef<UserRepository>;
String _$userControllerHash() => r'9fc735d0e6c8493582a1066ebdef33f9583e8163';

/// See also [UserController].
@ProviderFor(UserController)
final userControllerProvider =
    AutoDisposeAsyncNotifierProvider<UserController, AppUser?>.internal(
      UserController.new,
      name: r'userControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$userControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$UserController = AutoDisposeAsyncNotifier<AppUser?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
