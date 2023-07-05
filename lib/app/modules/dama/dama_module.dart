import 'package:bipixapp/app/modules/dama/dama_page.dart';
import 'package:bipixapp/app/modules/dama/dama_store.dart';
import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

class DamaModule extends WidgetModule {
  DamaModule({super.key});

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DamaStore()),
  ];

  @override
  Widget get view => const DamaPage();
}
