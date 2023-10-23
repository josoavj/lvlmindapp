// ignore_for_file: prefer_const_constructors

//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lvlmindbeta/animation.dart';
import 'package:lvlmindbeta/loginpage.dart';
import 'package:lvlmindbeta/redirecting.dart';
import 'package:lvlmindbeta/welcomepage.dart';

class Presentation extends StatelessWidget {
  const Presentation({super.key});

  // Added a constructor
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 255, 255, 255),
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomePage(),
                ));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 100,
            horizontal: 50,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff2441e7), Color(0xffff1053)],
            ),
            image: DecorationImage(
              image: const AssetImage('images/fond1 1.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 50,
              ),
              DelayedAnimation(
                delay: 1200,
                child: SizedBox(
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      'images/lvlind10.jpg',
                    ),
                  ), //Logo de notre application
                ),
              ),
              DelayedAnimation(
                delay: 1600,
                child: SizedBox(
                  height: 70,
                ),
              ),
              DelayedAnimation(
                delay: 1700,
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: const [
                      Text(
                        "Your adventure begins here and now.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Josefin',
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 255, 255, 255),
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
                          color: Color.fromARGB(255, 255, 255, 255),
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
                    vertical: 20,
                    horizontal: 50,
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
                          backgroundColor:
                              const Color.fromARGB(255, 248, 248, 248),
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
                                fontWeight: FontWeight.w400,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Texte avec lien de redirection dans une page redirecting
                      SizedBox(
                        child: Row(
                          // Placer les deux élements côte à côte
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize
                              .min, // Pour diminuer l'espacement entre les deuc élements
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontFamily: 'Josefin',
                                fontWeight: FontWeight.w400,
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Redirecting(),
                                  ),
                                );
                              },
                              child: const DelayedAnimation(
                                delay: 2500,
                                child: Text("Register",
                                    style: TextStyle(
                                      fontFamily: 'Josefin',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blueAccent,
                                      decoration: TextDecoration.underline,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
