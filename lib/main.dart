import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skrew_calculator/screens/calculator.dart';

void main() {
  runApp(ProviderScope(
    child: Calculator(),
  ));
}
