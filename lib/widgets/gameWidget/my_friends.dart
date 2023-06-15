import 'dart:convert';

import 'package:bipixapp/widgets/gameWidget/game_selection.dart';
import 'package:bipixapp/widgets/gameWidget/my_friends_game_selection.dart';
import 'package:bipixapp/widgets/gameWidget/select_friend.dart';
import 'package:bipixapp/widgets/gameWidget/select_new_friend.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../services/api.dart';
import '../../services/webservice.dart';

class Myfriends extends StatefulWidget {
  const Myfriends({Key? key}) : super(key: key);

  @override
  State<Myfriends> createState() => _MyfriendsState();
}

class _MyfriendsState extends State<Myfriends> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final Response response =
        await Webservice.get("listFriends/${await Webservice.getUserId()}");

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        users = jsonResponse;
        if (kDebugMode) {
          print("lista de amigos $users");
        }
      });
    } else {
      if (kDebugMode) {
        print(
            'Erro ao obter usuários. Código de status: ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> filteredUsers = [];
    final searchQuery = searchController.text.toLowerCase();

    if (searchQuery.isNotEmpty) {
      filteredUsers = users.where((user) {
        return (user["nome"] as String).contains(searchQuery);
      }).toList();
    } else {
      filteredUsers = users;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Procurar amigo",
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 15),
        Container(
          height: 40,
          width: 300,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: const Color(0XFF0472E8), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.9),
                spreadRadius: 1,
                blurRadius: 3,
              ),
            ],
          ),
          child: TextField(
            controller: searchController,
            style: const TextStyle(color: Colors.black, fontSize: 18),
            decoration: const InputDecoration(
              hintText: 'Ex: @example.bipix',
              border: InputBorder.none,
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 250,
          width: 300,
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 5),
            ],
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: filteredUsers.length,
            itemBuilder: (context, index) {
              final user = filteredUsers[index];

              return SelectFriend(
                nome: user["nome"],
                id: user["id"],
                onTap: () => inviteFriendDialog(
                  friendId: user["id"],
                  nome: user["nome"],
                ),
              );
            },
          ),
        )
            .animate()
            .fade(delay: 100.ms)
            .slideY(begin: 2, end: 0, curve: Curves.easeIn, duration: 500.ms)
            .then(),
      ],
    );
  }

  inviteFriendDialog({
    required String friendId,
    required String nome,
  }) {
    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (context) => AlertDialog(
        title: Text(
          'Escolha um jogo para jogar com $nome',
          style: TextStyle(fontSize: 16),
        ),
        content: Container(
          width: 200,
          height: 200,
          child: MyFriendsGameSelection(),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                String userId = await Webservice.getUserId();
                final response = await http.post(
                  Uri.parse('$baseUrl/inviteFriend'),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode({
                    'userId': userId,
                    'friendId': friendId,
                  }),
                );
                if (kDebugMode) {
                  print(response.body);
                }
                Navigator.pop(context);
              },
              child: const Text(
                'Convidar',
                style: TextStyle(color: Color(0XFF0472E8)),
              )),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}
