import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundWhite.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center());
  }
}
