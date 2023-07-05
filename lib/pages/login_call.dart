import 'package:flutter/material.dart';

class LoginCall extends StatelessWidget {
  const LoginCall({Key? key}) : super(key: key);
  static String name = "";
  static String userId = "";
  static String callId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (val) {
                name = val;
              },
              decoration: const InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (val) {
                userId = val;
              },
              decoration: const InputDecoration(
                hintText: "UserId",
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (val) {
                callId = val;
              },
              decoration: const InputDecoration(
                hintText: "CallId",
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/call');
                },
                child: const Text("Submit"))
          ],
        ),
      ),
    );
  }
}
