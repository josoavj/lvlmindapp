import 'package:flutter/material.dart';

/// Classe pour gérer les erreurs et afficher les messages d'erreur
class ErrorHandler {
  ErrorHandler._(); // Constructeur privé pour empêcher l'instanciation

  /// Affiche un SnackBar d'erreur
  static void showErrorSnackBar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = Colors.red,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }

  /// Affiche un SnackBar de succès
  static void showSuccessSnackBar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    showErrorSnackBar(
      context,
      message,
      duration: duration,
      backgroundColor: Colors.green,
    );
  }

  /// Affiche un SnackBar d'information
  static void showInfoSnackBar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    showErrorSnackBar(
      context,
      message,
      duration: duration,
      backgroundColor: Colors.blueAccent,
    );
  }

  /// Traite les erreurs et retourne un message utilisateur
  static String getErrorMessage(Exception error) {
    final errorString = error.toString();

    if (errorString.contains('Numéro de matricule ou mot de passe incorrect')) {
      return 'Numéro de matricule ou mot de passe incorrect.';
    } else if (errorString.contains('Une erreur est survenue')) {
      return 'Une erreur est survenue lors de la connexion.';
    } else if (errorString.contains('Aucun utilisateur connecté')) {
      return 'Aucun utilisateur connecté.';
    }

    // Retirer le préfixe "Exception: " si présent
    return errorString.replaceFirst('Exception: ', '');
  }
}
