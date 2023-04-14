import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PlayWithFriends extends StatefulWidget {
  const PlayWithFriends({super.key});

  @override
  State<PlayWithFriends> createState() => _PlayWithFriendsState();
}

class _PlayWithFriendsState extends State<PlayWithFriends> {
  @override
  Widget build(BuildContext context) {
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
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Colors.grey)),
          child: const TextField(
            style: TextStyle(color: Colors.black, fontSize: 18),
            decoration: InputDecoration(
              hintText: 'Ex: @example.bipix',
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(color: Colors.blue, spreadRadius: 3),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  '@Joaozinho',
                  style: TextStyle(fontSize: 24),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
