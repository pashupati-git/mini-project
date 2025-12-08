import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/message.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageModel with _$MessageModel {
  const MessageModel._();

  const factory MessageModel({
    required String id,
    required String senderId,
    required String chatId,
    required String content,
    required DateTime timestamp,
    @Default(false) bool isRead,
    @Default(MessageType.text) MessageType type,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Message toEntity() {
    return Message(
      id: id,
      senderId: senderId,
      chatId: chatId,
      content: content,
      timestamp: timestamp,
      isRead: isRead,
      type: type,
    );
  }

  factory MessageModel.fromEntity(Message message) {
    return MessageModel(
      id: message.id,
      senderId: message.senderId,
      chatId: message.chatId,
      content: message.content,
      timestamp: message.timestamp,
      isRead: message.isRead,
      type: message.type,
    );
  }
}