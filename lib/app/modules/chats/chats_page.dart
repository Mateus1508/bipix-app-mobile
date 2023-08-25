import 'package:bipixapp/services/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:bipixapp/app/modules/chats/chats_store.dart';
import 'package:flutter/material.dart';

import '../../../services/webservice.dart';
import '../../../widgets/custom_tabs.dart';
import 'widgets/chat_widget.dart';
import 'widgets/chats_app_bar.dart';

class ChatsPage extends StatefulWidget {
  final String title;
  const ChatsPage({Key? key, this.title = 'ChatsPage'}) : super(key: key);
  @override
  ChatsPageState createState() => ChatsPageState();
}

class ChatsPageState extends State<ChatsPage>
    with SingleTickerProviderStateMixin {
  final ChatsStore store = Modular.get();

  late final TabController tabController = TabController(
    length: 2,
    vsync: this,
  );

  Future getUser() async {
    final userId = await Webservice.getUserId();
    return FirebaseFirestore.instance.collection("users").doc(userId).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const ChatsAppBar(),
          vSpace(20),
          CustomTabs(
            tabController: tabController,
            tabs: const [
              Tab(text: "Conversas"),
              Tab(text: "Grupos"),
            ],
          ),
          vSpace(20),
          Expanded(
            child: FutureBuilder(
                future: getUser(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        10,
                        (index) => const ChatWidget(),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
