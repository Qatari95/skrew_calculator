import 'package:flutter/material.dart';
import 'package:skrew_calculator/players_list.dart';
import 'package:skrew_calculator/start_screen.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() {
    return _CalculatorState();
  }
}

class _CalculatorState extends State<Calculator> {
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'players-list';
    });
  }

  @override
  Widget build(BuildContext context) {
    var activeWidget = activeScreen == 'start-screen'
        ? StartScreen(switchScreen)
        : const PlayersList();

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
          child: activeWidget,
        ),
      ),
    );
  }
}
