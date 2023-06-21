import 'package:bipixapp/widgets/gameWidget/select_new_friend.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bipixapp/services/api.dart';

import '../../services/webservice.dart';
import 'select_friend.dart';

class AddNewFriends extends StatefulWidget {
  const AddNewFriends({Key? key});

  @override
  State<AddNewFriends> createState() => _AddNewFriendsState();
}

class _AddNewFriendsState extends State<AddNewFriends> {
  List<dynamic> users = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        users = jsonResponse;
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
        final name = user['name'] as String?;
        return name?.toLowerCase().contains(searchQuery) ?? false;
      }).toList();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Adicione um amigo",
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
        if (filteredUsers.isNotEmpty)
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
                final name = user['name'] as String?;
                return SelectFriend(
                  photo: user["photo"],
                  name: name,
                  id: user["id"] ?? "",
                  onTap: () => inviteFriendDialog(
                    photo: user["photo"],
                    name: name!,
                    id: user["id"],
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
    required String photo,
    required String name,
    required String id,
  }) {
    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (context) => AlertDialog(
        title: Text(
          'Quer adicionar $name na sua lista de amigos ?',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                String userId = await Webservice.getUserId();
                final response = await http.post(
                  Uri.parse('$baseUrl/addFriend'),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode({
                    'userId': userId,
                    'friendId': id,
                    'name': name,
                    // '': id,
                  }),
                );
                if (kDebugMode) {
                  print(response.body);
                }
                Navigator.pop(context);
              },
              child: const Text(
                'Adicionar',
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
