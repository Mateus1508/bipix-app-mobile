import 'package:flutter/material.dart';

class SettingsModalBottomSheeet extends StatelessWidget {
  const SettingsModalBottomSheeet({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
              top: -15,
              child: Container(
                width: 200,
                height: 7,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(30),
                ),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('bla'),
              Text('bla'),
              Text('bla'),
              Text('bla'),
            ],
          ),
        ]);
  }
}
