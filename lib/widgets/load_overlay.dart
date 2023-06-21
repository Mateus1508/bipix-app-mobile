import 'package:bipixapp/services/utilities.dart';
import 'package:flutter/material.dart';

class LoadOverlay {
  static OverlayEntry load() => OverlayEntry(
        builder: (context) => Positioned(
          child: Container(
            height: maxHeight(context),
            width: maxWidth(context),
            alignment: Alignment.center,
            color: const Color.fromRGBO(0, 0, 0, .3),
            child: const CircularProgressIndicator(),
          ),
        ),
      );
}
