import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'chats_page.dart';
import 'chats_store.dart';

class ChatsModule extends WidgetModule {
  ChatsModule({super.key});

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ChatsStore()),
  ];

  @override
  Widget get view => ChatsPage(key: super.key);
}
