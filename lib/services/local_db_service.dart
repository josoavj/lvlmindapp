import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import '../models/user_profile.dart';

/// Service de gestion de base de données locale avec Hive
class LocalDbService {
  static const String _usersBoxName = 'users';
  static const String _sessionBoxName = 'session';
  static const String _currentUserKey = 'current_user';

  late Box<Map> _usersBox;
  late Box<String> _sessionBox;

  /// Initialiser la base de données
  Future<void> initialize() async {
    await Hive.initFlutter();
    _usersBox = await Hive.openBox<Map>(_usersBoxName);
    _sessionBox = await Hive.openBox<String>(_sessionBoxName);
  }

  /// Ajouter un utilisateur à la base de données
  Future<void> addUser(UserProfile user) async {
    final userMap = _userProfileToMap(user);
    await _usersBox.put(user.matricule, userMap);
  }

  /// Récupérer un utilisateur par matricule
  UserProfile? getUser(String matricule) {
    final userMap = _usersBox.get(matricule);
    if (userMap != null) {
      return _mapToUserProfile(userMap.cast<String, dynamic>());
    }
    return null;
  }

  /// Récupérer tous les utilisateurs
  List<UserProfile> getAllUsers() {
    return _usersBox.values
        .map((userMap) => _mapToUserProfile(userMap.cast<String, dynamic>()))
        .toList();
  }

  /// Vérifier si un utilisateur existe
  bool userExists(String matricule) {
    return _usersBox.containsKey(matricule);
  }

  /// Mettre à jour un utilisateur
  Future<void> updateUser(UserProfile user) async {
    if (!_usersBox.containsKey(user.matricule)) {
      throw Exception('Utilisateur non trouvé: ${user.matricule}');
    }
    final userMap = _userProfileToMap(user);
    await _usersBox.put(user.matricule, userMap);
  }

  /// Supprimer un utilisateur
  Future<void> deleteUser(String matricule) async {
    await _usersBox.delete(matricule);
  }

  /// Sauvegarder l'utilisateur actuel connecté
  Future<void> saveCurrentUser(UserProfile user) async {
    final userJson = jsonEncode(_userProfileToMap(user));
    await _sessionBox.put(_currentUserKey, userJson);
  }

  /// Récupérer l'utilisateur actuel connecté
  UserProfile? getCurrentUser() {
    final userJson = _sessionBox.get(_currentUserKey);
    if (userJson != null) {
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return _mapToUserProfile(userMap);
    }
    return null;
  }

  /// Déconnecter l'utilisateur
  Future<void> logout() async {
    await _sessionBox.delete(_currentUserKey);
  }

  /// Vérifier si un utilisateur est connecté
  bool isUserLoggedIn() {
    return _sessionBox.containsKey(_currentUserKey);
  }

  /// Nettoyer les données sensibles
  Future<void> clearAllData() async {
    await _usersBox.clear();
    await _sessionBox.clear();
  }

  /// Convertir UserProfile en Map
  Map<String, dynamic> _userProfileToMap(UserProfile user) {
    return {
      'username': user.username,
      'password': user.password, // Stocker le hash du password (déjà hashé)
      'name': user.name,
      'email': user.email,
      'status': user.status,
      'matricule': user.matricule,
      'establishment': user.establishment,
      'avatarPath': user.avatarPath,
    };
  }

  /// Convertir Map en UserProfile
  UserProfile _mapToUserProfile(Map<String, dynamic> map) {
    return UserProfile(
      username: map['username'] as String,
      password: map['password'] as String? ??
          '', // Récupérer le hash du password stocké
      name: map['name'] as String,
      email: map['email'] as String,
      status: map['status'] as String,
      matricule: map['matricule'] as String,
      establishment: map['establishment'] as String,
      avatarPath: map['avatarPath'] as String,
    );
  }

  /// Chercher un utilisateur par email
  UserProfile? getUserByEmail(String email) {
    try {
      final user = _usersBox.values
          .map((userMap) => _mapToUserProfile(userMap.cast<String, dynamic>()))
          .firstWhere((user) => user.email == email);
      return user;
    } catch (e) {
      return null;
    }
  }

  /// Chercher un utilisateur par nom
  List<UserProfile> searchUsersByName(String query) {
    final lowerQuery = query.toLowerCase();
    return _usersBox.values
        .map((userMap) => _mapToUserProfile(userMap.cast<String, dynamic>()))
        .where((user) => user.name.toLowerCase().contains(lowerQuery))
        .toList();
  }

  /// Obtenir le nombre total d'utilisateurs
  int getUserCount() {
    return _usersBox.length;
  }

  /// Vérifier les stats de la base de données
  Map<String, dynamic> getDbStats() {
    return {
      'total_users': _usersBox.length,
      'is_user_logged_in': isUserLoggedIn(),
      'users_box_size': _usersBox.keys.length,
      'session_box_size': _sessionBox.keys.length,
    };
  }
}
