import 'package:flutter/material.dart';

import 'modal_item_option.dart';

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
          Container(
            width: 150,
            padding: const EdgeInsets.symmetric(
              vertical: 17,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ModalItem(
                  icon: Icons.dark_mode,
                  text: 'Aparência:',
                ),
                ModalItem(
                  icon: Icons.language,
                  text: 'Idioma:',
                ),
                ModalItem(
                  icon: Icons.person,
                  text: 'Alterar conta',
                ),
                ModalItem(
                  icon: Icons.help,
                  text: 'Ajuda',
                ),
              ],
            ),
          ),
        ]);
  }
}
