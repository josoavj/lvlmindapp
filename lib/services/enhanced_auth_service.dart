import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../models/user_profile.dart';
import '../utils/auth_exceptions.dart';
import 'local_db_service.dart';

/// Service d'authentification avec gestion de base de données locale
class EnhancedAuthService {
  final LocalDbService _db;

  EnhancedAuthService({required LocalDbService db}) : _db = db;

  /// Hacher un mot de passe avec SHA256
  static String _hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  /// Vérifier un mot de passe
  static bool _verifyPassword(String password, String hash) {
    return _hashPassword(password) == hash;
  }

  /// Enregistrer un nouvel utilisateur
  Future<UserProfile> register({
    required String username,
    required String password,
    required String name,
    required String email,
    required String status,
    required String matricule,
    required String establishment,
    String avatarPath = 'assets/images/icons/avatar1.jpg',
  }) async {
    // Vérifier si l'utilisateur existe déjà
    if (_db.userExists(matricule)) {
      throw AuthException(
          'L\'utilisateur avec le matricule $matricule existe déjà');
    }

    if (_db.getUserByEmail(email) != null) {
      throw AuthException('Un utilisateur avec cet email existe déjà');
    }

    // Créer l'utilisateur avec le password hashé
    final user = UserProfile(
      username: username,
      password: _hashPassword(password), // Stocker le hash, pas le password
      name: name,
      email: email,
      status: status,
      matricule: matricule,
      establishment: establishment,
      avatarPath: avatarPath,
    );

    // Sauvegarder dans la base de données
    await _db.addUser(user);
    return user;
  }

  /// Connecter un utilisateur
  Future<UserProfile?> login(String matricule, String password) async {
    try {
      final user = _db.getUser(matricule);

      if (user == null) {
        throw AuthException(AuthError.invalidCredentials);
      }

      // Vérifier le mot de passe
      if (!_verifyPassword(password, user.password)) {
        throw AuthException(AuthError.invalidCredentials);
      }

      // Sauvegarder la session
      await _db.saveCurrentUser(user);
      return user;
    } catch (e) {
      if (e is AuthException) {
        rethrow;
      }
      throw AuthException('${AuthError.connectionError} $e');
    }
  }

  /// Récupérer l'utilisateur actuellement connecté
  UserProfile? getLoggedInUser() {
    return _db.getCurrentUser();
  }

  /// Déconnecter l'utilisateur
  Future<void> logout() async {
    await _db.logout();
  }

  /// Vérifier si un utilisateur est connecté
  bool isUserLoggedIn() {
    return _db.isUserLoggedIn();
  }

  /// Mettre à jour le profil de l'utilisateur
  Future<void> updateUserProfile({
    required String matricule,
    String? name,
    String? email,
    String? avatarPath,
    String? status,
  }) async {
    final user = _db.getUser(matricule);

    if (user == null) {
      throw AuthException(AuthError.noUserLoggedIn);
    }

    final updatedUser = user.copyWith(
      name: name,
      email: email,
      avatarPath: avatarPath,
      status: status,
    );

    await _db.updateUser(updatedUser);
    await _db.saveCurrentUser(updatedUser);
  }

  /// Changer le mot de passe
  Future<void> changePassword({
    required String matricule,
    required String oldPassword,
    required String newPassword,
  }) async {
    final user = _db.getUser(matricule);

    if (user == null) {
      throw AuthException(AuthError.noUserLoggedIn);
    }

    // Vérifier l'ancien mot de passe
    if (!_verifyPassword(oldPassword, user.password)) {
      throw AuthException('L\'ancien mot de passe est incorrect');
    }

    // Mettre à jour le mot de passe
    final updatedUser = user.copyWith(
      password: _hashPassword(newPassword),
    );

    await _db.updateUser(updatedUser);
    await _db.saveCurrentUser(updatedUser);
  }

  /// Réinitialiser le mot de passe (pour "Mot de passe oublié")
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    final user = _db.getUserByEmail(email);

    if (user == null) {
      throw AuthException('Aucun utilisateur trouvé avec cet email');
    }

    final updatedUser = user.copyWith(
      password: _hashPassword(newPassword),
    );

    await _db.updateUser(updatedUser);
  }

  /// Obtenir les stats de la base de données
  Map<String, dynamic> getDbStats() {
    return _db.getDbStats();
  }
}
