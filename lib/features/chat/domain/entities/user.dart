import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    String? avatarUrl,
    @Default(false) bool isOnline,
    DateTime? lastSeen,
  }) = _User;
}
