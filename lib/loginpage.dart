import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lvlmindbeta/animation.dart';
import 'package:lvlmindbeta/presentation.dart';
import 'package:lvlmindbeta/welcomepage.dart';
// Suite à une erreur sur les polices que j'ait télechargé
// J'ai du revenir à googlefonts

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
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
            const SizedBox(
              height: 10,
            ),
            const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Image(
                  height: 50,
                  image: AssetImage('images/logomin.jpg'),
                ))
          ],
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 100,
                horizontal: 30,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DelayedAnimation(
                    delay: 1100,
                    child: Text(
                      'Connect to levelmind',
                      style: TextStyle(
                        fontFamily: 'PatrickHand',
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 22),
                  DelayedAnimation(
                    delay: 1200,
                    child: Text(
                      "It's recommended to connect with your ID.",
                      style: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 20,
                        color: Color.fromARGB(95, 15, 12, 199),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const LoginForm(),
            const SizedBox(height: 100),
            DelayedAnimation(
              delay: 1700,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  // J'ai utilisé primary mais elle est obsolète
                  // Du coup je l'ai remplacé par backgroundColor
                  backgroundColor: Colors.blueAccent,
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
                      builder: (context) => const WelcomePage(),
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
                    delay: 1900,
                    child: Text("Return",
                        style: TextStyle(
                          fontFamily: 'Josefin',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
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
            delay: 1800,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Your ID',
                labelStyle: TextStyle(
                  fontFamily: 'TiltNeon',
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          DelayedAnimation(
            delay: 1900,
            child: TextField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  fontFamily: 'TiltNeon',
                  color: Colors.grey[400],
                ),
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.visibility,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
