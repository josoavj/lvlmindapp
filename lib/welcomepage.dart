import 'package:flutter/material.dart';
import 'package:lvlmindbeta/animation.dart';
//import 'package:lvlmindbeta/main.dart';
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
              image: const AssetImage('images/fond3 1.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: Column(
            children: [
              // Espacement pour mieux centrer les élements
              const SizedBox(
                height: 100,
              ),
              /* aligmement des logos */
              Row(
                // Pour le logo de l'ISPM
                mainAxisSize: MainAxisSize.min,
                children: [
                  DelayedAnimation(
                    delay: 1200,
                    child: SizedBox(
                      height: 100,
                      child: Image.asset('images/ispm.jpg'),
                    ),
                  ),
                  // Juste un espacement etre les deux logos
                  const DelayedAnimation(
                    delay: 1250,
                    child: SizedBox(
                      width: 70,
                      child: null,
                    ),
                  ),
                  // Pour notre logo
                  DelayedAnimation(
                    delay: 1250,
                    child: SizedBox(
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          'images/lvlind10.jpg',
                        ),
                      ),
                    ),
                    // Our application's logo
                  ),
                ],
              ),

              // Juste pour l'espacement

              const SizedBox(height: 20),
              DelayedAnimation(
                delay: 1700,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 50,
                    bottom: 30,
                  ),
                  child: const Text('Online learning with',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 255, 255, 255),
                      )),
                ),
              ),
              DelayedAnimation(
                delay: 1750,
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 30,
                  ),
                  child: const Text('levelmind',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 50,
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 255, 255, 255),
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
                        color: Color.fromARGB(255, 255, 255, 255),
                      )),
                ),
              ),
              DelayedAnimation(
                delay: 2000,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
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
                        fontWeight: FontWeight.w600,
                        color: Colors.blueAccent,
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
