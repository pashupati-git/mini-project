// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatsHash() => r'a07a31c253ef05d790808b63a7f27ae9676bf740';

/// See also [chats].
@ProviderFor(chats)
final chatsProvider = AutoDisposeFutureProvider<List<Chat>>.internal(
  chats,
  name: r'chatsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChatsRef = AutoDisposeFutureProviderRef<List<Chat>>;
String _$chatDetailHash() => r'b5da976204dad742375285bdb0b2942d1ae29cda';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [chatDetail].
@ProviderFor(chatDetail)
const chatDetailProvider = ChatDetailFamily();

/// See also [chatDetail].
class ChatDetailFamily extends Family<AsyncValue<Chat>> {
  /// See also [chatDetail].
  const ChatDetailFamily();

  /// See also [chatDetail].
  ChatDetailProvider call(
    String chatId,
  ) {
    return ChatDetailProvider(
      chatId,
    );
  }

  @override
  ChatDetailProvider getProviderOverride(
    covariant ChatDetailProvider provider,
  ) {
    return call(
      provider.chatId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'chatDetailProvider';
}

/// See also [chatDetail].
class ChatDetailProvider extends AutoDisposeFutureProvider<Chat> {
  /// See also [chatDetail].
  ChatDetailProvider(
    String chatId,
  ) : this._internal(
          (ref) => chatDetail(
            ref as ChatDetailRef,
            chatId,
          ),
          from: chatDetailProvider,
          name: r'chatDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatDetailHash,
          dependencies: ChatDetailFamily._dependencies,
          allTransitiveDependencies:
              ChatDetailFamily._allTransitiveDependencies,
          chatId: chatId,
        );

  ChatDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chatId,
  }) : super.internal();

  final String chatId;

  @override
  Override overrideWith(
    FutureOr<Chat> Function(ChatDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChatDetailProvider._internal(
        (ref) => create(ref as ChatDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chatId: chatId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Chat> createElement() {
    return _ChatDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatDetailProvider && other.chatId == chatId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chatId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChatDetailRef on AutoDisposeFutureProviderRef<Chat> {
  /// The parameter `chatId` of this provider.
  String get chatId;
}

class _ChatDetailProviderElement extends AutoDisposeFutureProviderElement<Chat>
    with ChatDetailRef {
  _ChatDetailProviderElement(super.provider);

  @override
  String get chatId => (origin as ChatDetailProvider).chatId;
}

String _$currentUserIdHash() => r'e25235f9d21d8fc5d64d1ca3b59ab462005adce4';

/// See also [CurrentUserId].
@ProviderFor(CurrentUserId)
final currentUserIdProvider =
    AutoDisposeNotifierProvider<CurrentUserId, String>.internal(
  CurrentUserId.new,
  name: r'currentUserIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentUserId = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
