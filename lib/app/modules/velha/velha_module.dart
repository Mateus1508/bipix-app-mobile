import 'package:bipixapp/app/modules/velha/velha_page.dart';
import 'package:bipixapp/app/modules/velha/velha_store.dart';
import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

class VelhaModule extends WidgetModule {
  VelhaModule({super.key});

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => VelhaStore()),
  ];

  @override
  Widget get view => const VelhaPage();
}
