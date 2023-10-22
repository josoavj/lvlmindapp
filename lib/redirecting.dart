import 'package:flutter/material.dart';
import 'package:lvlmindbeta/animation.dart';
import 'package:lvlmindbeta/presentation.dart';
import 'package:flutter/gestures.dart';

class Redirecting extends StatelessWidget {
  const Redirecting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.blueAccent,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // Juste un widget centré avec les deux logos suivi d'un lien de redirection
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 100,
            horizontal: 80,
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DelayedAnimation(
                      delay: 100,
                      child: Image(
                          height: 100, image: AssetImage('images/ispm.jpg')),
                    ),
                    DelayedAnimation(
                        delay: 100,
                        child: SizedBox(
                          height: 10,
                        )),
                    DelayedAnimation(
                        delay: 100,
                        child: Image(
                          height: 100,
                          image: AssetImage('images/lvlmind.jpg'),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
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
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Link",
                      style: TextStyle(
                        fontFamily: 'Josefin',
                        color: Colors.blueAccent,
                        fontSize: 20,
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
    );
  }
}
