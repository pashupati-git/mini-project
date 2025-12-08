import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/chat.dart';
import 'chat_provider.dart';

part 'chat_state_provider.g.dart';

// Selected Chat Provider
@riverpod
class SelectedChat extends _$SelectedChat {
  @override
  String? build() => null;

  void selectChat(String chatId) {
    state = chatId;
  }

  void clearSelection() {
    state = null;
  }
}

// Unread Count Provider
@riverpod
class UnreadCount extends _$UnreadCount {
  @override
  Map<String, int> build() => {};

  void setUnreadCount(String chatId, int count) {
    state = {...state, chatId: count};
  }

  void incrementUnread(String chatId) {
    final currentCount = state[chatId] ?? 0;
    state = {...state, chatId: currentCount + 1};
  }

  void clearUnread(String chatId) {
    state = {...state, chatId: 0};
  }

  int getUnreadCount(String chatId) {
    return state[chatId] ?? 0;
  }

  int get totalUnread {
    return state.values.fold(0, (sum, count) => sum + count);
  }
}

// Search Query Provider
@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void updateQuery(String query) {
    state = query;
  }

  void clearQuery() {
    state = '';
  }
}

// Filtered Chats Provider (based on search)
@riverpod
Future<List<Chat>> filteredChats(FilteredChatsRef ref) async {
  final chats = await ref.watch(chatsProvider.future);
  final query = ref.watch(searchQueryProvider);

  if (query.isEmpty) {
    return chats;
  }

  return chats.where((chat) {
    return chat.name.toLowerCase().contains(query.toLowerCase()) ||
        (chat.lastMessage?.content.toLowerCase().contains(query.toLowerCase()) ?? false);
  }).toList();
}
