import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: const [
          SizedBox(
            height: 50,
            child: Card(
              color: Colors.blueAccent,
              elevation: 5,
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              CircleAvatar(
              radius: 30,
              child: Image(image: AssetImage("")),
            ),
            Text(
              "Josoa Vonjiniaina", // Student or Professor name
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Josefin',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black45),
            ),
            ]
          ),
            ),
          ),
          // Liste des cours les plus suivies
      
          // Statistique d'activité hebdomadaire
        ],
      )
        );
  }
}
