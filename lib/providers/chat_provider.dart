import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:uuid/uuid.dart';
import '../models/message.dart';
import '../models/user.dart';
import '../services/storage_service.dart';

// Provider for current user
final currentUserProvider = FutureProvider<User>((ref) async {
  final storage = ref.read(storageServiceProvider);
  return await storage.getCurrentUser();
});

// Provider for chat messages
final chatProvider = StateNotifierProvider<ChatNotifier, AsyncValue<List<Message>>>((ref) {
  return ChatNotifier(ref);
});

class ChatNotifier extends StateNotifier<AsyncValue<List<Message>>> {
  final Ref ref;
  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  User? _currentUser;

  // IMPORTANT: Change this to your WebSocket server URL
  // For testing, you can use: wss://echo.websocket.org (echo server)
  // For production: wss://your-server.com/ws
  static const String wsUrl = 'wss://echo.websocket.org';

  ChatNotifier(this.ref) : super(const AsyncValue.loading()) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      // Get current user from storage
      _currentUser = await ref.read(storageServiceProvider).getCurrentUser();

      // Connect to WebSocket
      _connectWebSocket();

      // Initialize with empty messages
      state = const AsyncValue.data([]);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void _connectWebSocket() {
    try {
      // Create WebSocket connection
      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

      // Listen to incoming messages
      _subscription = _channel!.stream.listen(
            (data) {
          _handleIncomingMessage(data);
        },
        onError: (error) {
          print('WebSocket error: $error');
        },
        onDone: () {
          print('WebSocket connection closed');
          // Attempt reconnection after 3 seconds
          Future.delayed(const Duration(seconds: 3), () {
            if (!mounted) return;
            _connectWebSocket();
          });
        },
      );
    } catch (e) {
      print('Failed to connect WebSocket: $e');
    }
  }

  void _handleIncomingMessage(dynamic data) {
    try {
      final jsonData = jsonDecode(data);

      // Parse incoming message
      final message = Message(
        id: jsonData['id'] ?? const Uuid().v4(),
        senderId: jsonData['senderId'] ?? 'unknown',
        senderName: jsonData['senderName'] ?? 'Unknown',
        text: jsonData['text'] ?? data.toString(),
        timestamp: DateTime.parse(jsonData['timestamp'] ?? DateTime.now().toIso8601String()),
        isMe: jsonData['senderId'] == _currentUser?.id,
      );

      // Add message to list
      state.whenData((messages) {
        state = AsyncValue.data([...messages, message]);
      });
    } catch (e) {
      // If JSON parsing fails, treat as plain text message
      final message = Message(
        id: const Uuid().v4(),
        senderId: 'echo',
        senderName: 'Echo Server',
        text: data.toString(),
        timestamp: DateTime.now(),
        isMe: false,
      );

      state.whenData((messages) {
        state = AsyncValue.data([...messages, message]);
      });
    }
  }

  // Send message through WebSocket
  void sendMessage(String text) {
    if (text.trim().isEmpty || _currentUser == null) return;

    final message = Message(
      id: const Uuid().v4(),
      senderId: _currentUser!.id,
      senderName: _currentUser!.name,
      text: text.trim(),
      timestamp: DateTime.now(),
      isMe: true,
    );

    // Add message to local state immediately
    state.whenData((messages) {
      state = AsyncValue.data([...messages, message]);
    });

    // Send to WebSocket server
    try {
      final payload = jsonEncode({
        'id': message.id,
        'senderId': message.senderId,
        'senderName': message.senderName,
        'text': message.text,
        'timestamp': message.timestamp.toIso8601String(),
      });
      _channel?.sink.add(payload);
    } catch (e) {
      print('Failed to send message: $e');
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _channel?.sink.close();
    super.dispose();
  }
}