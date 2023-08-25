import 'dart:convert';

import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    this.photo,
    this.size = 40,
  });

  final String? photo;

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size,
        width: size,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(color: Colors.grey, width: 1)),
          child: photo == null || photo!.isEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/bipixLogo.png',
                    fit: BoxFit.fitHeight,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.memory(
                    base64Decode(photo!),
                    fit: BoxFit.fill,
                  ),
                ),
        ) // substitui pela ft da pessoa
        );
  }
}
