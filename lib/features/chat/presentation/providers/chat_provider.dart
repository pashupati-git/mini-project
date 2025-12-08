import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/chat.dart';
import '../../data/repositories/chat_repository.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/user.dart';
part 'chat_provider.g.dart';

// Repository Provider
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository();
});

// Chat List Provider
@riverpod
Future<List<Chat>> chats(ChatsRef ref) async {
  final repository = ref.watch(chatRepositoryProvider);
  return await repository.getChats();
}

// Single Chat Detail Provider
@riverpod
Future<Chat> chatDetail(ChatDetailRef ref, String chatId) async {
  final repository = ref.watch(chatRepositoryProvider);
  return await repository.getChatById(chatId);
}

// Current User Provider
@riverpod
class CurrentUserId extends _$CurrentUserId {
  @override
  String build() => 'current_user';
}