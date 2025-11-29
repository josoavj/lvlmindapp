import 'package:flutter/material.dart';

/// Constantes de couleurs et de thème pour l'application
class ThemeConstants {
  ThemeConstants._(); // Constructeur privé pour empêcher l'instanciation

  // Couleurs principales
  static const Color primaryColor = Colors.blueAccent;
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color secondaryColor = Colors.pinkAccent;
  static const Color accentColor = Color.fromARGB(225, 249, 29, 88);

  // Couleurs de fond
  static const Color lightBackground = Colors.white;
  static const Color darkBackground = Color(0xFF1E1E1E);
  static const Color darkCardColor = Color(0xFF424242);

  // Couleurs de texte
  static const Color lightTextPrimary = Colors.black87;
  static const Color lightTextSecondary = Colors.black54;
  static const Color darkTextPrimary = Colors.white;
  static const Color darkTextSecondary = Colors.white70;

  // Gradients
  static const LinearGradient welcomeGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xff2441e7), Color(0xffff1053)],
  );

  // Ombres et élévations
  static const double appBarElevation = 0;
  static const double cardElevation = 4;

  // Rayon des bordures
  static const double borderRadiusLarge = 100;
  static const double borderRadiusMedium = 20;
  static const double borderRadiusSmall = 8;

  // Espacements
  static const double paddingSmall = 8;
  static const double paddingMedium = 16;
  static const double paddingLarge = 24;
  static const double paddingXLarge = 32;

  // Famille de polices
  static const String fontFamilyPatrickHand = 'PatrickHand';
  static const String fontFamilyJosefin = 'Josefin';
  static const String fontFamilyTiltNeon = 'TiltNeon';
  static const String fontFamilyAdlam = 'Adlam';

  // Tailles de police
  static const double fontSizeSmall = 12;
  static const double fontSizeMedium = 16;
  static const double fontSizeLarge = 20;
  static const double fontSizeXLarge = 24;
  static const double fontSizeXXLarge = 30;

  // Poids de police
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w600;
  static const FontWeight fontWeightSemiBold = FontWeight.w700;
  static const FontWeight fontWeightBold = FontWeight.w800;
}
