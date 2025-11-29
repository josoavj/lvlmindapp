import 'package:flutter/material.dart';
import 'theme_constants.dart';

/// Classe contenant les décorateurs et styles réutilisables pour l'UI
class UIConstants {
  UIConstants._(); // Constructeur privé pour empêcher l'instanciation

  // Décoration pour les InputField en mode clair
  static InputDecorationTheme lightInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[200],
      labelStyle: TextStyle(color: Colors.grey[700]),
      border: _buildInputBorder(),
      enabledBorder: _buildInputBorder(),
      focusedBorder: _buildInputBorder(
        borderColor: ThemeConstants.primaryColor,
        borderWidth: 2.0,
      ),
      errorBorder: _buildInputBorder(
        borderColor: Colors.red,
        borderWidth: 2.0,
      ),
      focusedErrorBorder: _buildInputBorder(
        borderColor: Colors.red,
        borderWidth: 2.0,
      ),
    );
  }

  // Décoration pour les InputField en mode sombre
  static InputDecorationTheme darkInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[700],
      labelStyle: TextStyle(color: Colors.grey[300]),
      border: _buildInputBorder(),
      enabledBorder: _buildInputBorder(),
      focusedBorder: _buildInputBorder(
        borderColor: ThemeConstants.primaryColor,
        borderWidth: 2.0,
      ),
      errorBorder: _buildInputBorder(
        borderColor: Colors.red,
        borderWidth: 2.0,
      ),
      focusedErrorBorder: _buildInputBorder(
        borderColor: Colors.red,
        borderWidth: 2.0,
      ),
    );
  }

  // Décoration de fond pour la page welcome
  static BoxDecoration welcomeBackgroundDecoration() {
    return BoxDecoration(
      gradient: ThemeConstants.welcomeGradient,
      image: DecorationImage(
        image: const AssetImage('assets/images/background/fond2.jpg'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withValues(alpha: 0.5),
          BlendMode.dstATop,
        ),
      ),
    );
  }

  // Style de bouton élevé standard
  static ButtonStyle elevatedButtonStyle({
    Color backgroundColor = ThemeConstants.primaryColor,
    Color foregroundColor = Colors.white,
  }) {
    return ElevatedButton.styleFrom(
      shape: const StadiumBorder(),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );
  }

  // Thème TextButton
  static TextStyle textButtonStyle({
    String fontFamily = ThemeConstants.fontFamilyJosefin,
    double fontSize = ThemeConstants.fontSizeSmall,
    FontWeight fontWeight = ThemeConstants.fontWeightMedium,
    Color color = ThemeConstants.primaryColor,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Construit un OutlineInputBorder avec rayon personnalisable
  static OutlineInputBorder _buildInputBorder({
    Color borderColor = Colors.transparent,
    double borderWidth = 0,
    double radius = ThemeConstants.borderRadiusLarge,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: borderColor, width: borderWidth),
    );
  }
}
