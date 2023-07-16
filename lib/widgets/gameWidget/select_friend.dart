import 'dart:convert';
import 'package:flutter/material.dart';

class SelectFriend extends StatelessWidget {
  final String? name;
  final String? photo;
  final String id;
  final void Function() onTap;

  const SelectFriend(
      {Key? key, this.name, this.photo, required this.id, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          padding: const EdgeInsets.all(2),
        ),
        onPressed: onTap,
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
                        color: Colors.black,
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
                '@${name ?? ''}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
