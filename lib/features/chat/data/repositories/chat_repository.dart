import 'dart:async';
import 'package:uuid/uuid.dart';
import '../../domain/entities/chat.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/i_chat_repository.dart';

class ChatRepository implements IChatRepository {
  final _uuid = const Uuid();
  final _messagesController = StreamController<List<Message>>.broadcast();

  // Mock data
  final List<User> _mockUsers = [
    User(
      id: '1',
      name: 'Alice Johnson',
      avatarUrl: null,
      isOnline: true,
    ),
    User(
      id: '2',
      name: 'Bob Smith',
      avatarUrl: null,
      isOnline: false,
      lastSeen: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    User(
      id: '3',
      name: 'Charlie Brown',
      avatarUrl: null,
      isOnline: true,
    ),
  ];

  final Map<String, List<Message>> _mockMessages = {};
  final String _currentUserId = 'current_user';

  ChatRepository() {
    _initializeMockData();
  }

  void _initializeMockData() {
    _mockMessages['chat_1'] = [
      Message(
        id: _uuid.v4(),
        senderId: '1',
        chatId: 'chat_1',
        content: 'Hey! How are you doing?',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: true,
      ),
      Message(
        id: _uuid.v4(),
        senderId: _currentUserId,
        chatId: 'chat_1',
        content: 'I\'m doing great! Thanks for asking.',
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
        isRead: true,
      ),
      Message(
        id: _uuid.v4(),
        senderId: '1',
        chatId: 'chat_1',
        content: 'That\'s wonderful to hear!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        isRead: false,
      ),
    ];

    _mockMessages['chat_2'] = [
      Message(
        id: _uuid.v4(),
        senderId: '2',
        chatId: 'chat_2',
        content: 'Did you see the game last night?',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
    ];

    _mockMessages['chat_3'] = [
      Message(
        id: _uuid.v4(),
        senderId: '3',
        chatId: 'chat_3',
        content: 'Meeting at 3 PM tomorrow?',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        isRead: true,
      ),
    ];
  }

  @override
  Future<List<Chat>> getChats() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      Chat(
        id: 'chat_1',
        name: _mockUsers[0].name,
        participants: [_mockUsers[0]],
        lastMessage: _mockMessages['chat_1']!.last,
        unreadCount: 1,
      ),
      Chat(
        id: 'chat_2',
        name: _mockUsers[1].name,
        participants: [_mockUsers[1]],
        lastMessage: _mockMessages['chat_2']!.last,
        unreadCount: 0,
      ),
      Chat(
        id: 'chat_3',
        name: _mockUsers[2].name,
        participants: [_mockUsers[2]],
        lastMessage: _mockMessages['chat_3']!.last,
        unreadCount: 0,
      ),
    ];
  }

  @override
  Future<Chat> getChatById(String chatId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final userIndex = int.parse(chatId.split('_')[1]) - 1;
    final user = _mockUsers[userIndex];

    return Chat(
      id: chatId,
      name: user.name,
      participants: [user],
      lastMessage: _mockMessages[chatId]?.lastOrNull,
    );
  }

  @override
  Future<List<Message>> getMessages(String chatId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockMessages[chatId] ?? [];
  }

  @override
  Future<Message> sendMessage(
      String chatId,
      String content,
      String senderId,
      ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final message = Message(
      id: _uuid.v4(),
      senderId: senderId,
      chatId: chatId,
      content: content,
      timestamp: DateTime.now(),
      isRead: false,
    );

    _mockMessages[chatId] = [..._mockMessages[chatId] ?? [], message];
    _messagesController.add(_mockMessages[chatId]!);

    // Simulate receiving a response after 2 seconds
    if (senderId == _currentUserId) {
      Future.delayed(const Duration(seconds: 2), () {
        final userIndex = int.parse(chatId.split('_')[1]) - 1;
        final response = Message(
          id: _uuid.v4(),
          senderId: _mockUsers[userIndex].id,
          chatId: chatId,
          content: _getAutoResponse(content),
          timestamp: DateTime.now(),
          isRead: false,
        );
        _mockMessages[chatId] = [..._mockMessages[chatId]!, response];
        _messagesController.add(_mockMessages[chatId]!);
      });
    }

    return message;
  }

  @override
  Future<void> markAsRead(String chatId, String messageId) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final messages = _mockMessages[chatId];
    if (messages != null) {
      final index = messages.indexWhere((m) => m.id == messageId);
      if (index != -1) {
        _mockMessages[chatId]![index] = messages[index].copyWith(isRead: true);
      }
    }
  }

  @override
  Stream<List<Message>> watchMessages(String chatId) {
    return _messagesController.stream
        .where((messages) => messages.first.chatId == chatId);
  }

  String _getAutoResponse(String message) {
    final responses = [
      'That\'s interesting! Tell me more.',
      'I see what you mean.',
      'Absolutely!',
      'That makes sense.',
      'Thanks for sharing!',
    ];
    return responses[message.length % responses.length];
  }

  void dispose() {
    _messagesController.close();
  }
}