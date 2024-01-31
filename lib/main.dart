// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:lvlmindbeta/screens/welcomepage.dart';

// ignore: constant_identifier_names
const d_color = Colors.blueAccent;
// ignore: constant_identifier_names
const b_color = Colors.white;

void main() {
  runApp(const lvlmind());
}
// Recommendation: Ajout de const avant lvlmind et Material app

class lvlmind extends StatelessWidget {
  const lvlmind({super.key});
  // Ajout d'un constructeur
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'lvlmind',
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
