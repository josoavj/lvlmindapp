import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/userProfile.dart';
import '../data/userData.dart';

class AuthService {
  static const String _loggedInUserKey = 'loggedInUser';

  Future<UserProfile?> login(String matricule, String password) async {
    try {
      final user = users.firstWhere(
            (u) => u.matricule == matricule && u.password == password,
      );
      await _saveLoggedInUser(user);
      return user;
    } on StateError {
      throw Exception('Numéro de matricule ou mot de passe incorrect.');
    } catch (e) {
      throw Exception('Une erreur est survenue lors de la connexion: $e');
    }
  }

  Future<UserProfile?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_loggedInUserKey);
    if (userJson != null) {
      return UserProfile.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  Future<void> _saveLoggedInUser(UserProfile user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_loggedInUserKey, jsonEncode(user.toJson()));
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loggedInUserKey);
  }

  Future<void> updateUserProfile({String? name, String? email}) async {
    final UserProfile? currentUser = await getLoggedInUser();
    if (currentUser == null) {
      throw Exception("Aucun utilisateur connecté pour la mise à jour.");
    }

    final updatedUser = currentUser.copyWith(
      name: name,
      email: email,
    );

    await _saveLoggedInUser(updatedUser);
  }
}