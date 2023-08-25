import 'package:mobx/mobx.dart';

part 'chats_store.g.dart';

class ChatsStore = _ChatsStoreBase with _$ChatsStore;

abstract class _ChatsStoreBase with Store {}
