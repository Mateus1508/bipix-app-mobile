import 'package:flutter/material.dart';

import '../services/utilities.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth(context),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: getColors(context).onBackground,
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: getColors(context).background,
          ),
          hSpace(15),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: TextFormField(
                decoration: InputDecoration.collapsed(
                  hintText: "Pesquisar",
                  hintStyle: getStyles(context).displayMedium?.copyWith(
                        color: getColors(context).background.withOpacity(.4),
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
