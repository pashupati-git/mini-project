import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/message.dart';
import 'chat_provider.dart';

part 'message_provider.g.dart';

// Messages List Provider
@riverpod
Future<List<Message>> messages(MessagesRef ref, String chatId) async {
  final repository = ref.watch(chatRepositoryProvider);
  return await repository.getMessages(chatId);
}

// Messages Stream Provider (for real-time updates)
@riverpod
Stream<List<Message>> messagesStream(MessagesStreamRef ref, String chatId) {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.watchMessages(chatId);
}

// Message Sender Provider (for sending messages)
@riverpod
class MessageSender extends _$MessageSender {
  @override
  FutureOr<void> build() {}

  Future<void> sendMessage(String chatId, String content) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(chatRepositoryProvider);
      final currentUserId = ref.read(currentUserIdProvider);

      await repository.sendMessage(chatId, content, currentUserId);

      // Invalidate messages to refresh the list
      ref.invalidate(messagesProvider(chatId));
    });
  }
}

// Typing Indicator Provider
@riverpod
class TypingIndicator extends _$TypingIndicator {
  @override
  Map<String, bool> build() => {};

  void setTyping(String chatId, bool isTyping) {
    state = {...state, chatId: isTyping};
  }

  bool isTyping(String chatId) {
    return state[chatId] ?? false;
  }
}