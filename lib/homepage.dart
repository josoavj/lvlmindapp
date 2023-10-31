// ignore_for_file: no_logic_in_create_state, unused_import, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:lvlmindbeta/main.dart';
import 'package:lvlmindbeta/animation.dart';
import 'package:lvlmindbeta/loginpage.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
  @override
  Widget build(context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text.rich(TextSpan(
                    text: "Hi honey \n",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Josefin',
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(
                        text: "Let's start a day exciting while learning",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Josefin',
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ])),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 80,
                  child: Image(
                    image: AssetImage('images/logomin.jpg'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
