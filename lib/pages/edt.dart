import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lvlmindbeta/pages/files.dart';
import 'package:lvlmindbeta/homepage.dart';
import 'package:lvlmindbeta/pages/profile.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});

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
              onDestinationSelected: (index) {
                switch (index) {
                  case 0:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Homepage()));
                    break;
                  case 1:
                    // Cette page
                    break;
                  case 2:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Files()));
                    break;
                  case 3:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Profile()));
                    break;
                }
              },
              backgroundColor: const Color.fromARGB(148, 55, 188, 255),
              elevation: 0,
              height: 75,
              selectedIndex: 1,
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
    );
  }
}
