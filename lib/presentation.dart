// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lvlmindbeta/animation.dart';
import 'package:lvlmindbeta/loginpage.dart';
import 'package:lvlmindbeta/redirecting.dart';

class Presentation extends StatelessWidget {
  const Presentation({super.key});
  // Added a constructor
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blueAccent,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DelayedAnimation(
              delay: 1200,
              child: SizedBox(
                height: 230,
                child: Image(
                  image: AssetImage('images/lvlmind.jpg'),
                ), //Logo de notre application
              ),
            ),
            DelayedAnimation(
              delay: 1300,
              child: Text(
                "LVLMIND",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Adlam',
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
            DelayedAnimation(
              delay: 1700,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 30,
                ),
                child: Column(
                  children: const [
                    Text(
                      "Your adventure begins here and now.",
                      style: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 16, 162, 236),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Train your mind to gain more knowledge with levelmind",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DelayedAnimation(
              delay: 2500,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 60,
                ),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.all(13),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          //Icon(Icons.send_sharp), //A modifier
                          SizedBox(width: 10),
                          Text(
                            'Connect with Personal ID',
                            style: TextStyle(
                              fontFamily: 'Josefin',
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Redirecting(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(13),
                      ),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          fontFamily: 'Josefin',
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
