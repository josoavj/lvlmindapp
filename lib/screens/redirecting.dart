// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lvlmindbeta/animations/simpleDelayedAnimation.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:lvlmindbeta/presentation.dart';
//import 'package:flutter/gestures.dart';

class Redirecting extends StatelessWidget {
  Redirecting({super.key});

//url vers notre site web
  String url =
      "http://192.168.43.128:8000/account/student-register/business-marketing";
      // URL obsolète
      // Recommendation: Ajouter un autre
  void _launchURL() async {
    if (await canLaunchUrl(url as Uri)) {
      await launchUrl(url as Uri);
    } else {
      throw 'Cannot open the link';
      // Nécessite une demande de naviguer vers une autre application
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    if (mediaQuery.size.width > 400) {
      // Pour les écrans plus larges que 600 pixels
      return largescreen(context);
    } else {
      // Pour les écrans de petite tailles
      return smallscreen(context);
    }
  }

  // Image de fond
  BoxDecoration background() {
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xff2441e7), Color(0xffff1053)],
      ),
      image: DecorationImage(
        image: const AssetImage('assets/images/background/fond1.jpg'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.5),
          BlendMode.dstATop,
        ),
      ),
    );
  }

  // Pour les écrans de grande taille
  Scaffold largescreen(BuildContext context) {
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
            // Bouton retour
          },
        ),
      ),
      // Juste un widget centré avec les deux logos suivi d'un lien de redirection
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          vertical: 250,
          horizontal: 50,
        ),
        // Pour la background de cette page
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: background(),

        // Le contenu de la page - Centré au centre
        child: Center(
          child: Align(
              alignment: Alignment.center,
              child: DelayedAnimation(
                  delay: 700,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    color: Colors.black.withOpacity(0.3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(
                                height: 100,
                                image: const AssetImage('assets/images/logo/ispm.jpg'),
                                errorBuilder: (BuildContext context,
                                    Object error, StackTrace? stackTrace) {
                                  return const Text("Image loading problem");
                                },
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    height: 100,
                                    image: const AssetImage(
                                        'assets/images/logo/lvlind10.jpg'),
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      return const Text(
                                          "Image loading problem");
                                    },
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Sponsored By',
                                      style: TextStyle(
                                        fontFamily: 'Josefin',
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GradientText(
                                      'ISPM',
                                      style: const TextStyle(
                                        fontFamily: 'Josefin',
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800,
                                      ),
                                      gradientType: GradientType.linear,
                                      colors: const [
                                        Color.fromARGB(189, 255, 255, 255),
                                        Color.fromARGB(255, 19, 121, 41)
                                      ],
                                    ),
                                  ],
                                ))),
                        const SizedBox(
                          child: Text(
                            "Online learning with us",
                            style: TextStyle(
                              fontFamily: 'Josefin',
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ),/*
> Flexibilité corrigé
*/
                        const SizedBox(
                          height: 60,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontFamily: 'Josefin',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              TextButton(
                                onPressed: _launchURL, // Appel de l'url
                                child: const Text(
                                  "Create",
                                  style: TextStyle(
                                    fontFamily: 'Josefin',
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ])
                      ],
                    ),
                  ))),
        ),
      ),
    );
  }

  // Pour les écrans de petite taille
  Scaffold smallscreen(BuildContext context) {
    return Scaffold(
      // Utile surtout pour la background
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 5,
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
          vertical: 210,
          horizontal: 45,
        ),
        // Pour la background de cette page
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: background(),
        // Le contenu de la page - Centré au centre
        child: Center(
          child: Align(
            alignment: Alignment.center,
            child: DelayedAnimation(
              delay: 750,
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
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Image(
                              height: 80,
                              image: AssetImage('assets/images/logo/ispm.jpg')),
                          const SizedBox(
                            width: 50,
                          ),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: const Image(
                                height: 80,
                                image: AssetImage('assets/images/logo/lvlind10.jpg'),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Sponsored By',
                                  style: TextStyle(
                                      fontFamily: 'Josefin', fontSize: 15),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                GradientText(
                                  'ISPM',
                                  style: const TextStyle(
                                    fontFamily: 'Josefin',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  gradientType: GradientType.linear,
                                  colors: const [
                                    Color.fromARGB(255, 105, 123, 227),
                                    Color.fromARGB(255, 25, 233, 115)
                                  ],
                                ),
                              ],
                            ))),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontFamily: 'Josefin',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          TextButton(
                            onPressed: _launchURL, // Appel de l'url
                            child: const Text(
                              "Create",
                              style: TextStyle(
                                fontFamily: 'Josefin',
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
