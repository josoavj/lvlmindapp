// ignore_for_file: prefer_const_constructors

//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lvlmindbeta/animation.dart';
import 'package:lvlmindbeta/loginpage.dart';
import 'package:lvlmindbeta/redirecting.dart';
import 'package:lvlmindbeta/welcomepage.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

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
      // Tsara natao container
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 0,
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
              image: const AssetImage('images/background/fond1.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
              ),
              DelayedAnimation(
                delay: 900,
                child: SizedBox(
                  height: 140,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      'images/logo/lvlind10.jpg',
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return Text("Image loading problem");
                      },
                    ),
                  ), //Logo de notre application
                ),
              ),
              DelayedAnimation(
                delay: 1000,
                child: SizedBox(
                  height: 60,
                ),
              ),
              DelayedAnimation(
                delay: 1000,
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: const [
                      Text(
                        "Your adventure begins here and now.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Josefin',
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        "Train your mind to gain more knowledge with levelmind",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Josefin',
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 1000,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 40,
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
                          children: [
                            //Icon(Icons.send_sharp), //A modifier
                            // SizedBox(width: 10),
                            GradientText(
                              'Connect with Personal ID',
                              style: TextStyle(
                                fontFamily: 'Josefin',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              gradientType: GradientType.linear,
                              colors: const [
                                Color(0xff2441e7),
                                Color(0xffff1053)
                              ],
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
                            Flexible(
                              flex: 2,
                              child: Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontFamily: 'Josefin',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Redirecting(),
                                    ),
                                  );
                                },
                                child: const DelayedAnimation(
                                  delay: 1050,
                                  child: Text("Register",
                                      style: TextStyle(
                                        fontFamily: 'Josefin',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        decoration: TextDecoration.underline,
                                      )),
                                ),
                              ),
                            )
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
