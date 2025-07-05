import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lvlmindbeta/navbar/navbar.dart'; // Make sure this path is correct

class Transition extends StatefulWidget {
  const Transition({super.key});

  @override
  State<Transition> createState() => _TransitionState();
}

class _TransitionState extends State<Transition> {
  @override
  void initState() {
    super.initState();
    _navigateToHome(); // Call the navigation function when the state initializes
  }

  // Asynchronous function to handle the delay and navigation
  Future<void> _navigateToHome() async {
    // Wait for 2 seconds before navigating
    await Future.delayed(const Duration(seconds: 2));

    // Check if the widget is still mounted before performing navigation.
    // This prevents the "use_build_context_synchronously" warning and potential errors
    // if the widget is disposed before the delay completes.
    if (!mounted) {
      return;
    }

    // Replace the current route with the BottomNavBar route
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BottomNavBar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // The entire screen will be covered by this container
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          // Gradient background
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff2441e7), Color(0xffff1053)],
          ),
          // Background image with an overlay to darken it
          image: DecorationImage(
            image: const AssetImage('assets/images/background/fond2.jpg'),
            fit: BoxFit.cover,
            // Apply a color filter to darken the image
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), // 50% black overlay
              BlendMode.dstATop, // Blends the color with the destination alpha
            ),
          ),
        ),
        child: Center(
          // Center the content (logo) vertically and horizontally
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center items vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Center items horizontally
            children: [
              // Display the SVG logo
              SvgPicture.asset(
                'assets/images/logo/LevelMind.svg',
                width: 250, // Set a fixed width for the SVG
                // alignment property here is less relevant as SvgPicture.asset
                // will size itself based on width/height or intrinsic size.
                // The Column's alignment will handle its position on screen.
              ),
            ],
          ),
        ),
      ),
    );
  }
}