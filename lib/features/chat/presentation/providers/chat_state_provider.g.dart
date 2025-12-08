// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredChatsHash() => r'dd58c88a0fc4d7d7842a4dc8906e24e44b936707';

/// See also [filteredChats].
@ProviderFor(filteredChats)
final filteredChatsProvider = AutoDisposeFutureProvider<List<Chat>>.internal(
  filteredChats,
  name: r'filteredChatsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredChatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredChatsRef = AutoDisposeFutureProviderRef<List<Chat>>;
String _$selectedChatHash() => r'e5e54ebc419655c391611304cd1768b2f067c50d';

/// See also [SelectedChat].
@ProviderFor(SelectedChat)
final selectedChatProvider =
    AutoDisposeNotifierProvider<SelectedChat, String?>.internal(
  SelectedChat.new,
  name: r'selectedChatProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$selectedChatHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedChat = AutoDisposeNotifier<String?>;
String _$unreadCountHash() => r'6d35e2292acdd2e1d5e78c46c84d40f6c2e30504';

/// See also [UnreadCount].
@ProviderFor(UnreadCount)
final unreadCountProvider =
    AutoDisposeNotifierProvider<UnreadCount, Map<String, int>>.internal(
  UnreadCount.new,
  name: r'unreadCountProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$unreadCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UnreadCount = AutoDisposeNotifier<Map<String, int>>;
String _$searchQueryHash() => r'5cfb8bc058f64b12d9a61421526a8ea7b414d4fa';

/// See also [SearchQuery].
@ProviderFor(SearchQuery)
final searchQueryProvider =
    AutoDisposeNotifierProvider<SearchQuery, String>.internal(
  SearchQuery.new,
  name: r'searchQueryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$searchQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchQuery = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
