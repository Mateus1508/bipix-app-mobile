import 'package:bipixapp/models/notification.dart';
import 'package:bipixapp/services/utilities.dart';
import 'package:bipixapp/services/webservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  Stream<QuerySnapshot<Map<String, dynamic>>> getNotificationsStream() async* {
    String userId = await Webservice.getUserId();
    await for (final query in FirebaseFirestore.instance
        .collection("usuários")
        .doc(userId)
        .collection("notifications")
        .orderBy("created_at", descending: true)
        .snapshots()) {
      yield query;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notificações"),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: getNotificationsStream(),
        builder: (context, notifSnap) {
          if (!notifSnap.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (notifSnap.data!.docs.isEmpty) {
            return Center(child: Text("Sem notificações ainda"));
          }
          return Column(
            children: notifSnap.data!.docs
                .map(
                  (docNotf) => NotificationWidget(
                      data: NotificationM.fromJson(docNotf.data())),
                )
                .toList(),
          );
        },
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key, required this.data});

  final NotificationM data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth(context),
      height: 75,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: getColors(context).primaryContainer),
        ),
      ),
      child: Row(
        children: [
          Avatar(),
          hSpace(5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: getStyles(context).titleSmall?.copyWith(
                        color: getColors(context).onBackground,
                      ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 4, top: 3, right: 5),
                  child: Text(
                    data.content,
                    style: getStyles(context).displaySmall?.copyWith(
                          color: getColors(context).secondaryContainer,
                          fontSize: 13,
                        ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          if (data.status == "WAITING_ANSWER") ...[
            NotificationButton(
              onTap: () {
                String function = "answerFriendRequest";
                if (data.type == "GAME_INVITE") function = "answerGameInvite";
                Webservice.post(function: function, body: {
                  "notification": data.toJson(),
                  "answer": true,
                });
              },
            ),
            hSpace(10),
            NotificationButton(
              onTap: () {
                String function = "answerFriendRequest";
                if (data.type == "GAME_INVITE") function = "answerGameInvite";
                Webservice.post(function: function, body: {
                  "notification": data.toJson(),
                  "answer": false,
                });
              },
              invert: true,
            ),
          ],
          if (data.status.contains("REFUSED") ||
              data.status.contains("ACCEPTED"))
            NotificationButton(
              onTap: () {},
              status: data.status.contains("REFUSED") ? "Recusado" : "Aceito",
              invert: data.status.contains("REFUSED"),
            ),
        ],
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: getColors(context).secondaryContainer),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5000),
        child: Image.asset(
          "assets/images/no-image.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class NotificationButton extends StatelessWidget {
  const NotificationButton({
    super.key,
    required this.onTap,
    this.invert = false,
    this.status = "",
  });

  final void Function() onTap;

  final bool invert;

  final String status;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: status.isEmpty ? 1 : .5,
      child: Material(
        color: invert ? getColors(context).error : getColors(context).primary,
        borderRadius: BorderRadius.circular(7),
        elevation: status.isEmpty ? 3 : 0,
        child: InkWell(
          onTap: status.isEmpty ? onTap : null,
          borderRadius: BorderRadius.circular(7),
          child: Container(
            width: status.isEmpty ? 50 : 76,
            height: 30,
            alignment: Alignment.center,
            child: Text(
              status.isNotEmpty
                  ? status
                  : invert
                      ? "NÃO"
                      : "SIM",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
