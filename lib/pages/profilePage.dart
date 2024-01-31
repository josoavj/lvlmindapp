import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage('avatar1.jpg')),
            Text(
              "Josoa Vonjiniaina",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Josefin',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }
}
