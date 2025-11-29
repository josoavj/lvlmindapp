import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/app_initialization_service.dart';

/// Provider pour gérer les données utilisateur connecté
class UserNotifier extends ChangeNotifier {
  UserProfile? _currentUser;
  bool _isLoading = false;
  String? _error;

  UserProfile? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _currentUser != null;

  /// Charger l'utilisateur actuel à partir de la session
  Future<void> loadCurrentUser() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // getLoggedInUser() est synchrone, pas besoin d'await
      final user = appInit.authService.getLoggedInUser();
      _currentUser = user;
      _error = null;
    } catch (e) {
      _error = e.toString();
      _currentUser = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Mettre à jour les données utilisateur
  Future<void> updateUser(UserProfile user) async {
    _currentUser = user;
    notifyListeners();
  }

  /// Déconnecter l'utilisateur
  Future<void> logout() async {
    try {
      await appInit.authService.logout();
      _currentUser = null;
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Effacer l'utilisateur
  void clearUser() {
    _currentUser = null;
    _error = null;
    notifyListeners();
  }
}
