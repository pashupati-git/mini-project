import '../entities/chat.dart';
import '../entities/message.dart';
import '../entities/user.dart';

abstract class IChatRepository {
  Future<List<Chat>> getChats();
  Future<Chat> getChatById(String chatId);
  Future<List<Message>> getMessages(String chatId);
  Future<Message> sendMessage(String chatId, String content, String senderId);
  Future<void> markAsRead(String chatId, String messageId);
  Stream<List<Message>> watchMessages(String chatId);
}