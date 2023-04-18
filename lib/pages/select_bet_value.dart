import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SelectBetValue extends StatefulWidget {
  const SelectBetValue({super.key});

  @override
  State<SelectBetValue> createState() => _SelectBetValueState();
}

class _SelectBetValueState extends State<SelectBetValue> {
  static const List<String> betValues = <String>[
    '3.00',
    '5.00',
    '7.50',
    '10.00',
    '20.00',
    '50.00'
  ];

  String dropdownValue = betValues.first;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10.0,
                        offset: Offset(0, 1.0),
                      )
                    ],
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.7), BlendMode.dstATop),
                      image: const AssetImage('assets/images/dama.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Dama',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 64,
                        letterSpacing: 15,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const Text('Escolha sua aposta'),
              const SizedBox(height: 10),
              DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(color: Colors.grey, blurRadius: 3),
                    ]),
                child: DropdownButton(
                    underline: const SizedBox(),
                    icon: const Visibility(
                        visible: false, child: Icon(Icons.arrow_downward)),
                    dropdownColor: Colors.white,
                    iconEnabledColor: Colors.black,
                    value: dropdownValue,
                    items: betValues.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: SizedBox(
                          width: 100.0,
                          // for example
                          child: Text(
                            items,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 32),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    }),
              ),
              const SizedBox(height: 20),
              const Text(
                '+ 6,00',
                style: TextStyle(
                  fontSize: 64,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 5),
              const Text('Você vai receber'),
              const SizedBox(height: 30),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/selectbet');
                      },
                      child: const Text(
                        'Avançar',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 36),
                      ),
                    ),
                    const Icon(
                      Icons.play_arrow_rounded,
                      size: 32,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
