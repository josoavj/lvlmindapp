//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lvlmindbeta/animation.dart';
import 'package:lvlmindbeta/homepage.dart';
import 'package:lvlmindbeta/presentation.dart';
import 'package:flutter_svg/flutter_svg.dart';
// Suite à une erreur sur les polices que j'ai télechargé
// J'ai du revenir à googlefonts

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 1,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.blueAccent,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Presentation(),
                      ));
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Flexible(
                flex: 2,
                child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Image(
                      height: 50,
                      image: AssetImage('images/logomin.jpg'),
                    )))
          ],
        ),
        titleSpacing: 0,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              'images/Vector.svg',
              width: 150,
              fit: BoxFit.fitHeight,
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset(
                'images/Vector (1).svg',
                width: 200,
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                'images/Vector (2).svg',
                width: 150,
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                'images/Ellipse 2.svg',
                width: 200,
              )),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 100,
                    horizontal: 30,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: DelayedAnimation(
                          delay: 800,
                          child: Text(
                            'Connect to levelmind',
                            style: TextStyle(
                              fontFamily: 'PatrickHand',
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(height: 22),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: DelayedAnimation(
                            delay: 850,
                            child: Flexible(
                              flex: 1,
                              child: Text(
                                "It's recommended to connect",
                                style: TextStyle(
                                  fontFamily: 'Josefin',
                                  fontSize: 20,
                                  color: Color.fromARGB(95, 15, 12, 199),
                                ),
                              ),
                            )),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: DelayedAnimation(
                            delay: 850,
                            child: Flexible(
                              flex: 1,
                              child: Text(
                                "with your ID.",
                                style: TextStyle(
                                  fontFamily: 'Josefin',
                                  fontSize: 20,
                                  color: Color.fromARGB(95, 15, 12, 199),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 0),
                const LoginForm(),
                const SizedBox(height: 50),
                DelayedAnimation(
                  delay: 1100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      // J'ai utilisé primary mais elle est obsolète
                      // Du coup je l'ai remplacé par backgroundColor
                      backgroundColor: const Color.fromARGB(160, 255, 16, 84),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 90,
                        vertical: 15,
                      ),
                    ),
                    child: const Text(
                      'CONFIRM',
                      style: TextStyle(
                        fontFamily: 'Josefin',
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Homepage(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 90),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 35),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Presentation(),
                              ));
                        },
                        child: const DelayedAnimation(
                          delay: 1100,
                          child: Flexible(
                              flex: 2,
                              child: Text(
                                "Return",
                                style: TextStyle(
                                    fontFamily: 'Josefin',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueAccent),
                              )),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: [
          DelayedAnimation(
            delay: 1000,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Your ID',
                labelStyle: TextStyle(
                  fontFamily: 'Josefin',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[400],
                ),
                filled: true, //remplissage de l'arrière-plan
                fillColor: const Color.fromARGB(90, 212, 212, 212),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(
                      color: Colors.transparent, // Couleur de la bordure
                      width: 2.0, // Largeur de la bordure
                    )),
              ),
            ),
          ),
          const SizedBox(height: 30),
          DelayedAnimation(
            delay: 1050,
            child: TextField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontFamily: 'Josefin',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[400],
                  ),
                  filled: true, //remplissage de l'arrière-plan
                  fillColor: const Color.fromARGB(90, 212, 212, 212),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.visibility,
                      color: Color.fromARGB(255, 82, 141, 243),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 295,
                      ),
                      borderRadius: BorderRadius.circular(100))),
            ),
          ),
        ],
      ),
    );
  }
}
