import 'package:flutter/material.dart';
import 'package:lvlmindbeta/animation.dart';
import 'package:lvlmindbeta/main.dart';
import 'package:lvlmindbeta/presentation.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
// Ajout d'un clé au constructeur
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 100,
            horizontal: 50,
          ),
          child: Column(
            children: [
              // Pour le logo de l'ISPM
              DelayedAnimation(
                delay: 1200,
                child: SizedBox(
                  height: 100,
                  child: Image.asset('images/ispm.jpg'),
                ),
              ),

              // Juste pour l'espacement
              const DelayedAnimation(
                delay: 1250,
                child: SizedBox(
                  height: 80,
                  child: null,
                  // Juste un espacement etre les deux logos
                ),
              ),

              // Pour notre logo
              DelayedAnimation(
                delay: 1500,
                child: SizedBox(
                  height: 100,
                  child: Image.asset('images/lvlmind.jpg'),
                  // Our application's logo
                ),
              ),
              const SizedBox(height: 20),
              DelayedAnimation(
                delay: 1700,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 50,
                    bottom: 30,
                  ),
                  child: const Text('Online learning with levelmind',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'TiltNeon',
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.blueAccent,
                      )),
                ),
              ),
              DelayedAnimation(
                delay: 1800,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                  ),
                  child: const Text(
                      "Build skills with courses, certificates and degrees online from world class universities",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 71, 136, 250),
                      )),
                ),
              ),
              DelayedAnimation(
                delay: 2000,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: d_color,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.all(13)),
                    // onHover: ,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Presentation(),
                        ),
                      );
                    },
                    child: const Text(
                      'GET STARTED',
                      style: TextStyle(
                        fontFamily: 'TiltNeon',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
