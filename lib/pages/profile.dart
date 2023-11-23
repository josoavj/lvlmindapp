import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 25,
              offset: const Offset(0, 20))
        ]),
        child: ClipRRect(
          // Pour obtenir des bords arrondis
          borderRadius: BorderRadius.circular(30),
          child: NavigationBar(
              onDestinationSelected: (index) => {},
              backgroundColor: const Color.fromARGB(148, 55, 188, 255),
              elevation: 0,
              height: 75,
              selectedIndex: 0,
              indicatorColor: const Color.fromARGB(255, 255, 255, 255),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Iconsax.home_2),
                  label: 'Home',
                ),
                NavigationDestination(
                    icon: Icon(Iconsax.calendar), label: 'EDT'),
                NavigationDestination(
                  icon: Icon(Iconsax.folder_2),
                  label: 'Files',
                ),
                NavigationDestination(
                    icon: Icon(Iconsax.profile_circle), label: 'Profile')
              ]),
        ),
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
