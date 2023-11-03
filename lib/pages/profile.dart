import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        // Pour obtenir des bords arrondis
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: NavigationBar(
            onDestinationSelected: (index) => {},
            backgroundColor: const Color.fromARGB(148, 55, 188, 255),
            elevation: 0,
            height: 75,
            selectedIndex: 0,
            indicatorColor: const Color.fromARGB(255, 255, 255, 255),
            //onDestinationSelected: (index) => ,
            destinations: const [
              NavigationDestination(
                icon: Icon(Iconsax.home_2),
                label: 'Home',
              ),
              NavigationDestination(icon: Icon(Iconsax.calendar), label: 'EDT'),
              NavigationDestination(
                  icon: Icon(Iconsax.folder_2), label: 'Files'),
              NavigationDestination(
                  icon: Icon(Iconsax.profile_circle), label: 'Profile')
            ]),
      ),
      body: const Center(
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
