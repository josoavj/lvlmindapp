import 'dart:convert'; // Pour encoder/décoder en JSON
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/userProfile.dart';
import '../data/userData.dart';

class AuthService {
  static const String _loggedInUserKey = 'loggedInUser';

  /// Tente de connecter un utilisateur.
  /// Retourne le UserProfile si la connexion réussit, null sinon.
  Future<UserProfile?> login(String username, String password) async {
    final user = users.firstWhere(
          (u) => u.username == username && u.password == password,
      orElse: () => throw Exception('Identifiants invalides'), // Ou retourne null
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