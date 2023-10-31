import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lvlmindbeta/animation.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
//import 'package:lvlmindbeta/presentation.dart';
//import 'package:flutter/gestures.dart';

class Redirecting extends StatelessWidget {
  const Redirecting({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    if (mediaQuery.size.width > 600) {
      // Pour les écrans plus larges que 600 pixels
      return Scaffold(
        // Utile surtout pour la background
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0),
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Color.fromARGB(255, 255, 255, 255),
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        // Juste un widget centré avec les deux logos suivi d'un lien de redirection
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            vertical: 270,
            horizontal: 50,
          ),
          // Pour la background de cette page
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

          // Le contenu de la page - Centré au centre
          child: Center(
            child: Align(
                alignment: Alignment.center,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                  color: Colors.black.withOpacity(0.3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Align(
                        alignment: Alignment.center,
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const DelayedAnimation(
                              delay: 100,
                              child: Image(
                                  height: 100,
                                  image: AssetImage('images/ispm.jpg')),
                            ),
                            const DelayedAnimation(
                                delay: 100,
                                child: SizedBox(
                                  width: 50,
                                )),
                            DelayedAnimation(
                              delay: 100,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: const Image(
                                    height: 100,
                                    image: AssetImage('images/lvlind10.jpg'),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                          child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: GradientText(
                          'ISPM ~ LevelMind',
                          style: const TextStyle(
                            fontFamily: 'PatrickHand',
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                          gradientType: GradientType.linear,
                          colors: const [
                            Color.fromARGB(255, 105, 123, 227),
                            Color.fromARGB(255, 25, 233, 115)
                          ],
                        ),
                      )),
                      const SizedBox(
                        child: Text(
                          "Online learning with us",
                          style: TextStyle(
                            fontFamily: 'Adlam',
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      SizedBox(
                        child: Text.rich(
                          TextSpan(
                              text: "Don't have an account?",
                              style: const TextStyle(
                                fontFamily: 'Josefin',
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              children: [
                                TextSpan(
                                    text: "Create",
                                    style: const TextStyle(
                                      fontFamily: 'Josefin',
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        //Redirection vers notre site web
                                      })
                              ]),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      );
    } else {
      // Pour les écrans de petite tailles
      return Scaffold(
        // Utile surtout pour la background
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0),
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Color.fromARGB(255, 255, 255, 255),
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        // Juste un widget centré avec les deux logos suivi d'un lien de redirection
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            vertical: 240,
            horizontal: 30,
          ),
          // Pour la background de cette page
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

          // Le contenu de la page - Centré au centre
          child: Center(
            child: Align(
              alignment: Alignment.center,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                color: Colors.black.withOpacity(0.3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const DelayedAnimation(
                            delay: 100,
                            child: Image(
                                height: 100,
                                image: AssetImage('images/ispm.jpg')),
                          ),
                          const DelayedAnimation(
                              delay: 100,
                              child: SizedBox(
                                width: 50,
                              )),
                          DelayedAnimation(
                            delay: 100,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: const Image(
                                  height: 100,
                                  image: AssetImage('images/lvlind10.jpg'),
                                )),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                        child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: GradientText(
                        'ISPM ~ LevelMind',
                        style: const TextStyle(
                          fontFamily: 'PatrickHand',
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                        gradientType: GradientType.linear,
                        colors: const [
                          Color.fromARGB(255, 105, 123, 227),
                          Color.fromARGB(255, 25, 233, 115)
                        ],
                      ),
                    )),
                    const SizedBox(
                      child: Text(
                        "Online learning with us",
                        style: TextStyle(
                          fontFamily: 'Adlam',
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const SizedBox(
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
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),

                          // Normalement, ceci aurait dû être un TextButton
                          // Qui, une fois cliqué, conduira l'utilisateur vers notre site web
                          Text(
                            "Create",
                            style: TextStyle(
                              fontFamily: 'Josefin',
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
