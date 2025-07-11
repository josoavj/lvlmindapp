import 'package:flutter/material.dart';
import '../services/authentificationService.dart';
import 'package:lvlmindbeta/screens/loginpage.dart';

/// Gère la logique de déconnexion et la navigation vers la page de connexion.
class DeconnexionService {
  /// Affiche une boîte de dialogue de confirmation et, si l'utilisateur confirme,
  /// effectue la déconnexion et redirige vers la LoginPage.
  static Future<void> showLogoutConfirmation(BuildContext context, AuthService authService) async {
    final bool? confirmLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text(
            "Déconnexion",
            style: TextStyle(
              fontFamily: 'Josefin',
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          content: const Text(
            "Êtes-vous sûr de vouloir vous déconnecter ?",
            style: TextStyle(
              fontFamily: 'Josefin',
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false), // Non
              child: const Text(
                "Annuler",
                style: TextStyle(
                  fontFamily: 'Josefin',
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(dialogContext).pop(true), // Oui
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Confirmer",
                style: TextStyle(
                  fontFamily: 'Josefin',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmLogout == true) {
      await authService.logout();
      debugPrint("Déconnexion de l'utilisateur effectuée via AuthService."); // Pour le débogage

      // Redirection vers la page de connexion
      // Utilisation de `pushAndRemoveUntil` pour empêcher l'utilisateur de revenir
      // à la page précédente après la déconnexion.
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
              (Route<dynamic> route) => false, // Supprime toutes les routes précédentes de la pile
        );
      }
    }
  }
}