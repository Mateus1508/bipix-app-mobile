import 'dart:convert';
import 'dart:io';

import 'package:bipixapp/services/webservice.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/api.dart';

class SelectFriend extends StatelessWidget {
  final String? nome;
  final String? photo;
  final String id;

  const SelectFriend({Key? key, this.nome, this.photo, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          backgroundColor: const Color(0XFF0472E8),
          padding: const EdgeInsets.all(2),
        ),
        onPressed: () {
          showDialog(
            context: context,
            useRootNavigator: true,
            builder: (context) => AlertDialog(
              title: const Text(
                'Quer adicionar (nome do amigo) na sua lista de amigos ?',
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
                          'nome': nome,
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
                  onPressed: () {},
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  height: 40,
                  width: 40,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: photo == null || photo!.isEmpty
                        ? Image.asset('assets/images/bipixLogo.png')
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.memory(
                              base64Decode(photo!),
                              fit: BoxFit.fill,
                            ),
                          ),
                  ) // substitui pela ft da pessoa
                  ),
              const SizedBox(
                width: 20,
              ),
              Text(
                '@${nome ?? ''}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
