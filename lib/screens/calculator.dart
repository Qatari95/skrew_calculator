import 'package:flutter/material.dart';
import 'package:skrew_calculator/screens/players_list.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() {
    return _CalculatorState();
  }
}

class _CalculatorState extends State<Calculator> {
  var activeScreen = 'players-list';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                Color.fromARGB(255, 37, 1, 44),
                Color.fromARGB(255, 160, 6, 190)
              ],
            ),
          ),
          child: const PlayersList(),
        ),
      ),
    );
  }
}
