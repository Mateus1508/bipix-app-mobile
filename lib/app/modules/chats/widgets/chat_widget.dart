import 'package:flutter/material.dart';

import '../../../../services/utilities.dart';
import '../../../../widgets/avatar_widget.dart';
import '../chat_page.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatPage(),
          )),
      child: Container(
        width: maxWidth(context),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: getColors(context).onSurfaceVariant,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            hSpace(15),
            const AvatarWidget(),
            hSpace(20),
            Flexible(
              child: SizedBox(
                height: 55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Bia",
                        style: getStyles(context).displayMedium?.copyWith(
                              color: getColors(context).onBackground,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    vSpace(5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check,
                          size: 13,
                          color: getColors(context).onBackground,
                        ),
                        hSpace(5),
                        Expanded(
                          child: Text(
                            "Bora jogar hoje?",
                            style: getStyles(context).displaySmall?.copyWith(
                                  color: getColors(context).onBackground,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            hSpace(10),
            Column(
              children: [
                Text(
                  "11:11 pm",
                  style:
                      getStyles(context).displaySmall?.copyWith(fontSize: 10),
                ),
                vSpace(7),
                Container(
                  height: 20,
                  width: 20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "1",
                    style: getStyles(context).displaySmall?.copyWith(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
