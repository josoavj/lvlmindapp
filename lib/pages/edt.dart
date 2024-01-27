import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lvlmindbeta/pages/files.dart';
import 'package:lvlmindbeta/homepage.dart';
import 'package:lvlmindbeta/pages/profile.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      //bottomNavigationBar: navbar(context),
    );
  }

  // Barre d'application
  AppBar appbar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      title: const Text(
        'Schedule',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Josefin',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.blue,
        ),
      ),
    );
  }
}

