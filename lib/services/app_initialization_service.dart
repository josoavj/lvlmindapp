import 'package:flutter/material.dart';
import '../services/local_db_service.dart';
import '../services/enhanced_auth_service.dart';
import '../data/user_data.dart';

/// Service d'initialisation de l'application
class AppInitializationService {
  static final AppInitializationService _instance =
      AppInitializationService._internal();

  late LocalDbService _localDbService;
  late EnhancedAuthService _authService;

  factory AppInitializationService() {
    return _instance;
  }

  AppInitializationService._internal();

  /// Initialiser l'application
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    // 1. Initialiser la base de données locale
    _localDbService = LocalDbService();
    await _localDbService.initialize();

    // 2. Initialiser le service d'authentification
    _authService = EnhancedAuthService(db: _localDbService);

    // 3. Pré-charger les données de test (à faire une seule fois)
    await _seedInitialData();

    debugPrint('✅ Application initialisée avec succès');
    _printDbStats();
  }

  /// Pré-charger les données de test dans la base de données
  Future<void> _seedInitialData() async {
    // Vérifier si les données sont déjà chargées
    if (_localDbService.getUserCount() > 0) {
      debugPrint('ℹ️  Données déjà présentes dans la base de données');
      return;
    }

    try {
      debugPrint('📥 Chargement des données de test...');

      // Ajouter les utilisateurs de test
      for (final user in users) {
        await _authService.register(
          username: user.username,
          password: user.password, // Le password sera hashé dans register()
          name: user.name,
          email: user.email,
          status: user.status,
          matricule: user.matricule,
          establishment: user.establishment,
          avatarPath: user.avatarPath,
        );
      }

      debugPrint('✅ ${users.length} utilisateurs de test chargés');
    } catch (e) {
      debugPrint('⚠️  Erreur lors du chargement des données: $e');
    }
  }

  /// Afficher les stats de la base de données
  void _printDbStats() {
    final stats = _authService.getDbStats();
    debugPrint('📊 Stats de la base de données:');
    debugPrint('   - Utilisateurs: ${stats['total_users']}');
    debugPrint('   - Utilisateur connecté: ${stats['is_user_logged_in']}');
  }

  /// Obtenir le service de base de données
  LocalDbService get localDbService => _localDbService;

  /// Obtenir le service d'authentification
  EnhancedAuthService get authService => _authService;

  /// Réinitialiser la base de données (pour debug)
  Future<void> resetDatabase() async {
    await _localDbService.clearAllData();
    await _seedInitialData();
    debugPrint('🔄 Base de données réinitialisée');
  }
}

/// Instance globale pour l'accès facile
final appInit = AppInitializationService();
