import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:lvlmindbeta/loginpage.dart';
import 'package:lvlmindbeta/Models/Courses.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 50,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(TextSpan(
                    text: "Hi there \n",
                    style: TextStyle(
                      fontFamily: 'Josefin',
                      color: Color.fromARGB(111, 0, 0, 0),
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                    children: [
                      TextSpan(
                          text:
                              "Let's start a day exciting \n while learning with us",
                          style: TextStyle(
                            fontFamily: 'Josefin',
                            fontSize: 17,
                            color: Color.fromARGB(97, 0, 0, 0),
                          ))
                    ])),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 60,
                  child: Image(image: AssetImage('images/lvlmind.jpg')),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
