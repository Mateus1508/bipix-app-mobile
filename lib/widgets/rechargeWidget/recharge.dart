import 'package:bipixapp/widgets/rechargeWidget/recharge_point.dart';
import 'package:bipixapp/widgets/rechargeWidget/vip.dart';
import 'package:flutter/material.dart';

class Recharge extends StatefulWidget {
  const Recharge({super.key});

  @override
  State<Recharge> createState() => _RechargeState();
}

class _RechargeState extends State<Recharge> {
  List<String> rechardgeOptions = ["Raspadinha premiada", "Quero ser VIP"];
  int selectOption = 0;

  navigationRechargeItems() {
    if (selectOption == 0) {
      return const RechargePoint();
    }
    if (selectOption == 1) {
      return const Vip();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 40,
          padding: const EdgeInsetsDirectional.all(5),
          margin: const EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, index) => buildNavigation(index, context),
          ),
        ),
        navigationRechargeItems(),
      ],
    );
  }

  Container buildNavigation(int index, BuildContext context) {
    return Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: index == selectOption ? Colors.black : Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            selectOption = index;
          });
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Text(
          rechardgeOptions[index],
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
