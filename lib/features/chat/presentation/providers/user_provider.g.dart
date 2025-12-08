// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentUserHash() => r'9673a13ff5879fbe6b2f40ed3f4312d211637d40';

/// See also [CurrentUser].
@ProviderFor(CurrentUser)
final currentUserProvider =
    AutoDisposeNotifierProvider<CurrentUser, User>.internal(
  CurrentUser.new,
  name: r'currentUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentUser = AutoDisposeNotifier<User>;
String _$onlineUsersHash() => r'dda3596a3bccd1c8bbe7f1e54346e4f5c6f2586d';

/// See also [OnlineUsers].
@ProviderFor(OnlineUsers)
final onlineUsersProvider =
    AutoDisposeNotifierProvider<OnlineUsers, Set<String>>.internal(
  OnlineUsers.new,
  name: r'onlineUsersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$onlineUsersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OnlineUsers = AutoDisposeNotifier<Set<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
