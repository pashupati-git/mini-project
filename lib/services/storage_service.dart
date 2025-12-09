import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/user.dart';

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

class StorageService {
  static const String _userIdKey = 'user_id';
  static const String _userNameKey = 'user_name';

  // Get or create current user
  Future<User> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();

    String? userId = prefs.getString(_userIdKey);
    String? userName = prefs.getString(_userNameKey);

    // If user doesn't exist, create new one
    if (userId == null || userName == null) {
      userId = const Uuid().v4();
      userName = 'User${userId.substring(0, 4)}';

      await prefs.setString(_userIdKey, userId);
      await prefs.setString(_userNameKey, userName);
    }

    return User(id: userId, name: userName);
  }

  // Update user name
  Future<void> updateUserName(String newName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, newName);
  }
}
