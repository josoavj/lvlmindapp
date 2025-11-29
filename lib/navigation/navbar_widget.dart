import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart'; // Make sure this package is correctly added to your pubspec.yaml
import 'package:lvlmindbeta/pages/home_page.dart';
import 'package:lvlmindbeta/pages/schedule_page.dart';
import 'package:lvlmindbeta/pages/files_page.dart';
import 'package:lvlmindbeta/pages/profile_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _pageIndex = 0; // Use a leading underscore for private variables

  // A list of the screens to be displayed
  final List<Widget> _screens = [
    const Homepage(), // Use const for widget instances that don't change
    const Schedule(),
    const Files(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_pageIndex], // Display the selected page
      bottomNavigationBar: Container(
        height: 70, // Consistent height for the nav bar
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.blueAccent, // Apply background color to the container
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            currentIndex: _pageIndex,
            onTap: (value) {
              setState(() {
                _pageIndex = value;
              });
            },
            type:
                BottomNavigationBarType.fixed, // Ensures all items are visible
            backgroundColor:
                Colors.transparent, // Make inner background transparent
            selectedItemColor: Colors.white,
            unselectedItemColor:
                Colors.white.withValues(alpha: 0.7), // Slightly dim unselected icons
            selectedFontSize: 12, // Adjusted font size for better fit
            unselectedFontSize: 10,
            iconSize: 25,
            showUnselectedLabels: false, // Only show label for selected item
            showSelectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: Icon(_pageIndex == 0 ? Iconsax.home_1 : Iconsax.home),
                label: "Accueil", // Using French for labels as per context
                tooltip: "Accueil",
              ),
              BottomNavigationBarItem(
                icon: Icon(_pageIndex == 1
                    ? CupertinoIcons.calendar_circle_fill
                    : CupertinoIcons.calendar_circle),
                label: "Agenda",
                tooltip: "Agenda",
              ),
              BottomNavigationBarItem(
                icon: Icon(_pageIndex == 2
                    ? CupertinoIcons.folder_fill
                    : CupertinoIcons.folder),
                label: "Fichiers",
                tooltip: "Fichiers",
              ),
              BottomNavigationBarItem(
                icon: Icon(_pageIndex == 3
                    ? CupertinoIcons.person_circle_fill
                    : CupertinoIcons.person_circle),
                label: "Profil",
                tooltip: "Profil",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
