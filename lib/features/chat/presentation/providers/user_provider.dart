import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_provider.g.dart';

// Current User Provider (full user object)
@riverpod
class CurrentUser extends _$CurrentUser {
  @override
  User build() {
    return const User(
      id: 'current_user',
      name: 'Me',
      isOnline: true,
    );
  }

  void updateUser(User user) {
    state = user;
  }

  void updateOnlineStatus(bool isOnline) {
    state = state.copyWith(isOnline: isOnline);
  }
}

// Online Users Provider
@riverpod
class OnlineUsers extends _$OnlineUsers {
  @override
  Set<String> build() => {};

  void addOnlineUser(String userId) {
    state = {...state, userId};
  }

  void removeOnlineUser(String userId) {
    state = state.where((id) => id != userId).toSet();
  }

  bool isUserOnline(String userId) {
    return state.contains(userId);
  }
}