import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/chat/presentation/screens/chat_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Chat',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const ChatListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}