import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class rechargePoint extends StatefulWidget {
  const rechargePoint({super.key});

  @override
  State<rechargePoint> createState() => _rechargePointState();
}

class _rechargePointState extends State<rechargePoint> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("Ponto de recarga"),
    );
  }
}
