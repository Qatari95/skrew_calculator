import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startq, {super.key});
  final void Function() startq;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/skrew_logo.jpg',
            width: 300,
          ),
          const SizedBox(height: 20),
          Text(
            'Skrew Calculator',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                color: Color.fromARGB(255, 34, 6, 53),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            icon: const Icon(
              Icons.start,
              color: Color.fromARGB(255, 160, 6, 190),
            ),
            onPressed: startq,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 2, 39, 65),
              side: const BorderSide(
                color: Color.fromARGB(255, 160, 6, 190),
              ),
            ),
            label: const Text(
              'Start',
              style: TextStyle(
                color: Color.fromARGB(255, 160, 6, 190),
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
