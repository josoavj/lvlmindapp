import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';
import '../data/user_data.dart';
import '../utils/auth_exceptions.dart';

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
      throw AuthException(AuthError.invalidCredentials);
    } catch (e) {
      throw AuthException('${AuthError.connectionError} $e');
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
      throw AuthException(AuthError.noUserLoggedIn);
    }

    final updatedUser = currentUser.copyWith(
      name: name,
      email: email,
    );

    await _saveLoggedInUser(updatedUser);
  }
}
