import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:lvlmindbeta/animation.dart';
//import 'package:lvlmindbeta/main.dart';
import 'package:lvlmindbeta/presentation.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
// Ajout d'un clé au constructeur
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      // ignore: non_constant_identifier_names
      body: LayoutBuilder(builder: (context, Constraints) {
        return Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
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
                      delay: 1000,
                      child: SizedBox(
                        height: 80,
                        child: Image.asset('images/ispm.jpg'),
                      ),
                    ),
                    // Juste un espacement etre les deux logos
                    const DelayedAnimation(
                      delay: 1000,
                      child: SizedBox(
                        width: 70,
                        child: null,
                      ),
                    ),
                    // Pour notre logo
                    DelayedAnimation(
                      delay: 1000,
                      child: SizedBox(
                        height: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
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
                  delay: 1400,
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 50,
                      bottom: 30,
                    ),
                    child: const Text('Online learning with',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Josefin',
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Color.fromARGB(255, 255, 255, 255),
                        )),
                  ),
                ),
                DelayedAnimation(
                  delay: 1450,
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 30,
                    ),
                    child: const Text('levelmind',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Josefin',
                          fontSize: 45,
                          fontWeight: FontWeight.w800,
                          color: Color.fromARGB(255, 255, 255, 255),
                        )),
                  ),
                ),
                DelayedAnimation(
                  delay: 1500,
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
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 255, 255, 255),
                        )),
                  ),
                ),
                DelayedAnimation(
                  delay: 1600,
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
                      child: GradientText(
                        'GET STARTED',
                        style: const TextStyle(
                          fontFamily: 'TiltNeon',
                          fontWeight: FontWeight.w600,
                        ),
                        gradientType: GradientType.linear,
                        colors: const [Color(0xff2441e7), Color(0xffff1053)],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
