import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: ListView(
        children: [
          const SizedBox(
            child: Card(),
          ),
          Table()
        ],
      ),
    );
  }

  // Barre d'application
  AppBar appbar() {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
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

