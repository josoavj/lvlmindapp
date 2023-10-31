import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:lvlmindbeta/animation.dart';
//import 'package:lvlmindbeta/main.dart';
import 'package:lvlmindbeta/presentation.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
// Ajout d'un clé au constructeur
  @override
  Widget build(BuildContext context) {
    /*
    
     */
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      // ignore: non_constant_identifier_names
      body: LayoutBuilder(builder: (context, Constraints) {
        return Center(
          child: Container(
            alignment: Alignment.center,
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /* aligmement des logos */
                Row(
                  // Pour le logo de l'ISPM
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DelayedAnimation(
                        delay: 800,
                        child: Flexible(
                          flex: 2,
                          child: SizedBox(
                            height: 85,
                            child: Image.asset(
                              'images/ispm.jpg',
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return const Text("Image loading problem");
                              },
                            ),
                          ),
                        )),
                    // Juste un espacement etre les deux logos
                    const DelayedAnimation(
                        delay: 800,
                        child: Flexible(
                          flex: 1,
                          child: SizedBox(
                            width: 70,
                            child: null,
                          ),
                        )),
                    // Pour notre logo
                    DelayedAnimation(
                        delay: 800,
                        child: Flexible(
                          flex: 2,
                          child: SizedBox(
                            height: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'images/lvlind10.jpg',
                                errorBuilder: (BuildContext context,
                                    Object error, StackTrace? stackTrace) {
                                  return const Text("Image loading problem");
                                },
                              ),
                            ),
                          ),
                        )
                        // Our application's logo
                        ),
                  ],
                ),

                // Juste pour l'espacement

                const Flexible(
                  flex: 1,
                  child: SizedBox(height: 20),
                ),
                DelayedAnimation(
                    delay: 850,
                    child: Flexible(
                      flex: 1,
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
                    )),
                DelayedAnimation(
                  delay: 850,
                  child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: Flexible(
                        flex: 2,
                        child: SvgPicture.asset(
                          'images/LevelMind.svg',
                          width: 250,
                          alignment: Alignment.bottomCenter,
                        ),
                      )),
                ),
                DelayedAnimation(
                  delay: 950,
                  child: Container(
                      margin: const EdgeInsets.only(
                        top: 30,
                        bottom: 20,
                      ),
                      child: const Flexible(
                        flex: 2,
                        child: Text(
                            "Build skills with courses, certificates and degrees online from world class universities",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Josefin',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 255, 255, 255),
                            )),
                      )),
                ),
                DelayedAnimation(
                    delay: 1000,
                    child: Flexible(
                      flex: 2,
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
                            colors: const [
                              Color(0xff2441e7),
                              Color(0xffff1053)
                            ],
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        );
      }),
    );
  }
}
