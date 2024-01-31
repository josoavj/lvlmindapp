import 'package:flutter/material.dart';

class ProfProfile extends StatefulWidget {
  const ProfProfile({super.key});

  @override
  State<ProfProfile> createState() => _ProfProfileState();
}

class _ProfProfileState extends State<ProfProfile> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(
               "About (Professor)", 
               style: TextStyle(
                     fontFamily: 'Josefin', 
                     height: 20, 
                     color: Colors.white
        ),),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}