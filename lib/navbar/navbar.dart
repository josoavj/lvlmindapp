import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lvlmindbeta/homepage.dart';
import 'package:lvlmindbeta/pages/edt.dart';
import 'package:lvlmindbeta/pages/files.dart';
import 'package:lvlmindbeta/pages/profile.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BottomNavBar> {
final list_screens = [
  Homepage(),
  Schedule(),
  Files(),
  Profile(),  
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: ),
    );
  }
}