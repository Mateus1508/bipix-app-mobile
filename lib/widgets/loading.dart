import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Image.asset('assets/images/bipixLogo.png')
              .animate(
                onPlay: (controller) => controller.repeat(),
              )
              .flipH(
                begin: 1,
                end: 2,
                duration: 1000.ms,
                curve: Curves.easeInOut,
              )
              .scaleXY(begin: 0, end: 1.5)
              .then(delay: 500.ms)
              .flipV(
                begin: 2,
                end: 1,
                duration: 1000.ms,
                curve: Curves.easeInOut,
              )
              .scaleXY(begin: 1.5, end: 0),
        ),
      ),
    );
    ;
  }
}
