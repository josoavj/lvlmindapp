// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:lvlmindbeta/main.dart';
import 'package:lvlmindbeta/animation.dart';
import 'package:lvlmindbeta/loginpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  Widget build(BuildContext) {
    return Scaffold(
      body: Container(
        child: const Column(
          children: [
            Row(
              children: [
                SizedBox(
                  child: Text('None'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
