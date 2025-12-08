import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_provider.g.dart';

class ChatNotification {
  final String chatId;
  final String message;
  final DateTime timestamp;

  ChatNotification({
    required this.chatId,
    required this.message,
    required this.timestamp,
  });
}

// Notifications Provider
@riverpod
class Notifications extends _$Notifications {
  @override
  List<ChatNotification> build() => [];

  void addNotification(ChatNotification notification) {
    state = [...state, notification];
  }

  void removeNotification(ChatNotification notification) {
    state = state.where((n) => n != notification).toList();
  }

  void clearAll() {
    state = [];
  }

  List<ChatNotification> getNotificationsForChat(String chatId) {
    return state.where((n) => n.chatId == chatId).toList();
  }
}