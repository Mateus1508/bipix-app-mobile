import 'package:flutter/material.dart';

import '../../../../services/utilities.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    bool authorship = index % 2 == 0;
    return Container(
      width: maxWidth(context),
      margin: const EdgeInsets.only(bottom: 10, right: 15, left: 15),
      alignment: authorship ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            authorship ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            "11:11 pm",
            style: getStyles(context).displaySmall?.copyWith(
                  color: getColors(context).onBackground,
                  fontSize: 11,
                ),
          ),
          vSpace(5),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            constraints: BoxConstraints(maxWidth: maxWidth(context) * 2 / 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: authorship
                  ? getColors(context).primary
                  : getColors(context).onPrimaryContainer,
            ),
            child: Text(
              authorship
                  ? "fala irmão, vamos sim, cria o desafio aí $index"
                  : "oi tudo bem, vamos jogar? $index",
              style: getStyles(context).displayMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
