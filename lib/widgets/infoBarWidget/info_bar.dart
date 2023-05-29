import 'package:bipixapp/widgets/infoBarWidget/notifications_modal.dart';
import 'package:flutter/material.dart';

class InfoBar extends StatefulWidget implements PreferredSizeWidget {
  const InfoBar({super.key});

  @override
  State<InfoBar> createState() => _InfoBarState();

  @override
  Size get preferredSize => const Size.fromHeight(45.0);
}

class _InfoBarState extends State<InfoBar> {
  @override
  Widget build(BuildContext context) {
    String cash = "400,00";

    void _handleShowModalBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) => DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.4,
          minChildSize: 0.32,
          maxChildSize: 0.9,
          builder: (context, scrollController) => SingleChildScrollView(
            controller: scrollController,
            child: const NotificationsModalBottomSheeet(),
          ),
        ),
      );
    }

    return AppBar(
      backgroundColor: const Color(0XFF0472E8),
      elevation: 2,
      leading: Image.asset('assets/images/bipixLogo.png'),
      actions: [
        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 70),
                padding: const EdgeInsets.only(right: 7, left: 1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 1,
                        spreadRadius: 3),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.wallet,
                      color: Colors.black,
                      size: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "\$ $cash",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Stack(
                  children: <Widget>[
                    IconButton(
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => _handleShowModalBottomSheet(context),
                      icon: const Icon(Icons.notifications),
                    ),
                    Positioned(
                      right: 20,
                      top: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Text('3'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
