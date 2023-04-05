import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RechargePoint extends StatefulWidget {
  const RechargePoint({super.key});

  @override
  State<RechargePoint> createState() => _RechargePointState();
}

class _RechargePointState extends State<RechargePoint> {
  List<String> rechardgeOptions = ["Raspadinha premiada", "Quero ser VIP"];
  int selectOption = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(vertical: 30),
            padding: const EdgeInsetsDirectional.all(5),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: rechardgeOptions.length,
              itemBuilder: (context, index) => buildNavigation(index, context),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Minhas raspadinhas",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 240),
            child: Column(
              children: [
                const Text(
                  "Recarrega grátis",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.amber.shade300,
                          blurRadius: 9,
                          spreadRadius: 10),
                    ],
                    color: Colors.amber.shade500,
                  ),
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Image.asset('assets/images/recarregar.png'),
                  ),
                )
                    .animate(onPlay: (controller) => controller.repeat())
                    .scaleXY(
                        begin: 0.9,
                        end: 1,
                        duration: 1000.ms,
                        curve: Curves.easeInOut)
                    .then()
                    .scaleXY(
                        begin: 1,
                        end: 0.9,
                        duration: 1500.ms,
                        curve: Curves.easeInOut),
                const SizedBox(height: 15),
                const Text("Toque para assistir")
                    .animate(onPlay: (controller) => controller.repeat())
                    .fadeIn(begin: 0.5, duration: 1000.ms, curve: Curves.easeIn)
                    .then()
                    .fadeOut(duration: 700.ms, curve: Curves.easeOut),
                const SizedBox(height: 10),
                const Text(
                  "Ganhe + \$ 1.00",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                const SizedBox(height: 10),
                const Text(
                    "Quando você assiste um anúncio,você ajuda a Bipix continuar Grátis."),
              ],
            ),
          ),
        ],
      ),
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
