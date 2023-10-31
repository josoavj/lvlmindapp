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
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Container(
        child: const Column(
          children: [
            Row(
              children: [
                Text.rich(TextSpan(
                    text: "Hi honey \n",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Josefin',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(
                        text: "Let's start a day exciting \n while learning",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Josefin',
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ])),
                SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
