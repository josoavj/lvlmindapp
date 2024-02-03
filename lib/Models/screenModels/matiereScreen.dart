import 'package:flutter/material.dart';

class MatContent extends StatefulWidget {
  const MatContent({super.key});

  @override
  State<MatContent> createState() =>  _MatContentState();
}

class  _MatContentState extends State<MatContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: const Text(
          "Courses",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Josefin'),
        ),
      ),
    );
  }
}