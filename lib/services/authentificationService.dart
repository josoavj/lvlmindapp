import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/userProfile.dart';
import '../data/userData.dart';
class AuthService {
  static const String _loggedInUserKey = 'loggedInUser';

  /// Tente de connecter un utilisateur en utilisant le numéro de matricule et le mot de passe.
  /// Retourne le UserProfile si la connexion réussit, null sinon.
  Future<UserProfile?> login(String matricule, String password) async { // CHANGEMENT: matricule au lieu de username
    final user = users.firstWhere(
          (u) => u.matricule == matricule && u.password == password, // CHANGEMENT: recherche par matricule
      orElse: () => throw Exception('Numéro de matricule ou mot de passe incorrect.'), // Message d'erreur mis à jour
    );

    if (user != null) {
      await _saveLoggedInUser(user);
      return user;
    }
    return null;
  }

  /// Récupère le profil de l'utilisateur connecté depuis le stockage local.
  Future<UserProfile?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_loggedInUserKey);
    if (userJson != null) {
      return UserProfile.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  /// Sauvegarde les informations de l'utilisateur connecté.
  Future<void> _saveLoggedInUser(UserProfile user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_loggedInUserKey, jsonEncode(user.toJson()));
  }

  /// Déconnecte l'utilisateur en supprimant ses informations du stockage local.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loggedInUserKey);
  }
}