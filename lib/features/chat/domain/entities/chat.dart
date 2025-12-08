import 'package:freezed_annotation/freezed_annotation.dart';
import 'message.dart';
import 'user.dart';

part 'chat.freezed.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    required String id,
    required String name,
    required List<User> participants,
    Message? lastMessage,
    @Default(0) int unreadCount,
    String? avatarUrl,
  }) = _Chat;
}