import 'package:flutter/material.dart';

class NotificationsModalBottomSheeet extends StatelessWidget {
  const NotificationsModalBottomSheeet({super.key});

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
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                    'Coloca as notificações pra aparecer aqui, qndo terminar eu ajeito o front'),
              ],
            ),
          ),
        ]);
  }
}
