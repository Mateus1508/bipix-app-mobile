import 'package:bipixapp/services/utilities.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class LoginCall extends StatelessWidget {
  const LoginCall({Key? key}) : super(key: key);
  static String name = "";
  static String userId = "";
  static String callId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (val) {
                name = val;
              },
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (val) {
                userId = val;
              },
              decoration: InputDecoration(
                hintText: "UserId",
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (val) {
                callId = val;
              },
              decoration: InputDecoration(
                hintText: "CallId",
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/call');
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
