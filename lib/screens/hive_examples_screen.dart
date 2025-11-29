import 'package:flutter/material.dart';
import '../services/enhanced_auth_service.dart';
import '../services/app_initialization_service.dart';

/// Exemples d'utilisation du service d'authentification avec Hive
///
/// Démonstration des cas d'usage courants:
/// - Enregistrement
/// - Connexion
/// - Gestion du profil
/// - Changement de mot de passe
/// - Déconnexion

class HiveExamplesScreen extends StatefulWidget {
  const HiveExamplesScreen({super.key});

  @override
  State<HiveExamplesScreen> createState() => _HiveExamplesScreenState();
}

class _HiveExamplesScreenState extends State<HiveExamplesScreen> {
  late EnhancedAuthService authService;
  String _output = '🟢 Prêt pour les tests...';

  @override
  void initState() {
    super.initState();
    authService = appInit.authService;
  }

  void _log(String message) {
    setState(() {
      _output = '$message\n$_output';
    });
    debugPrint(message);
  }

  /// Exemple 1: Enregistrement d'un nouvel utilisateur
  Future<void> _exampleRegister() async {
    _log('📝 Enregistrement d\'un nouvel utilisateur...');

    try {
      await authService.register(
        username: 'jean_dupont',
        password: 'SecurePass123!',
        name: 'Jean Dupont',
        email: 'jean.dupont@lvlmind.com',
        status: 'Étudiant',
        matricule: '202410',
        establishment: 'ISPM Lycée',
        avatarPath: 'assets/images/icons/avatar1.jpg',
      );

      _log('✅ Utilisateur enregistré: jean_dupont (202410)');
    } catch (e) {
      _log('❌ Erreur: $e');
    }
  }

  /// Exemple 2: Connexion avec les identifiants corrects
  Future<void> _exampleLoginSuccess() async {
    _log('🔐 Tentative de connexion correcte...');

    try {
      final user = await authService.login('202301', 'password123');
      _log('✅ Connecté avec succès: ${user?.name}');
      _log('   Email: ${user?.email}');
      _log('   Status: ${user?.status}');
    } catch (e) {
      _log('❌ Erreur: $e');
    }
  }

  /// Exemple 3: Connexion avec identifiants incorrects
  Future<void> _exampleLoginFail() async {
    _log('🔐 Tentative de connexion avec mauvais mot de passe...');

    try {
      await authService.login('202301', 'wrongpassword');
      _log('✅ Connecté (ne devrait pas arriver ici)');
    } catch (e) {
      _log('❌ Erreur attendue: $e');
    }
  }

  /// Exemple 4: Vérifier l'utilisateur connecté
  Future<void> _exampleGetLoggedInUser() async {
    _log('👤 Récupération de l\'utilisateur connecté...');

    final user = authService.getLoggedInUser();
    if (user != null) {
      _log('✅ Utilisateur connecté trouvé:');
      _log('   Nom: ${user.name}');
      _log('   Email: ${user.email}');
      _log('   Matricule: ${user.matricule}');
    } else {
      _log('ℹ️  Aucun utilisateur connecté');
    }
  }

  /// Exemple 5: Mettre à jour le profil
  Future<void> _exampleUpdateProfile() async {
    _log('✏️  Mise à jour du profil utilisateur...');

    try {
      await authService.updateUserProfile(
        matricule: '202301',
        name: 'Josoa Vonjiniaina (Updated)',
        email: 'josoa.updated@lvlmind.com',
        status: 'Professeur',
      );

      _log('✅ Profil mis à jour avec succès');

      // Récupérer les données mises à jour
      final updated = appInit.localDbService.getUser('202301');
      _log('   Nouveau nom: ${updated?.name}');
      _log('   Nouveau email: ${updated?.email}');
      _log('   Nouveau status: ${updated?.status}');
    } catch (e) {
      _log('❌ Erreur: $e');
    }
  }

  /// Exemple 6: Changer le mot de passe
  Future<void> _exampleChangePassword() async {
    _log('🔑 Changement de mot de passe...');

    try {
      await authService.changePassword(
        matricule: '202301',
        oldPassword: 'password123',
        newPassword: 'NewPassword456!',
      );

      _log('✅ Mot de passe changé avec succès');

      // Tester la connexion avec le nouveau password
      _log('🔐 Test de connexion avec le nouveau password...');
      final user = await authService.login('202301', 'NewPassword456!');
      _log('✅ Connexion réussie avec le nouveau password: ${user?.name}');
    } catch (e) {
      _log('❌ Erreur: $e');
    }
  }

  /// Exemple 7: Réinitialiser le mot de passe (mot de passe oublié)
  Future<void> _exampleResetPassword() async {
    _log('🔄 Réinitialisation du mot de passe (mot de passe oublié)...');

    try {
      await authService.resetPassword(
        email: 'josoa@lvlmind.com',
        newPassword: 'TempPassword123!',
      );

      _log('✅ Mot de passe réinitialisé');
      _log('🔐 Test de connexion avec le mot de passe temporaire...');
      final user = await authService.login('202301', 'TempPassword123!');
      _log('✅ Connexion réussie: ${user?.name}');
    } catch (e) {
      _log('❌ Erreur: $e');
    }
  }

  /// Exemple 8: Déconnexion
  Future<void> _exampleLogout() async {
    _log('🚪 Déconnexion...');

    try {
      await authService.logout();
      _log('✅ Déconnecté avec succès');

      // Vérifier
      final user = authService.getLoggedInUser();
      if (user == null) {
        _log('✅ Confirmation: Aucun utilisateur connecté');
      }
    } catch (e) {
      _log('❌ Erreur: $e');
    }
  }

  /// Exemple 9: Opérations sur la base de données
  Future<void> _exampleDbOperations() async {
    _log('📊 Opérations sur la base de données...');

    final db = appInit.localDbService;

    // Compter les utilisateurs
    final count = db.getUserCount();
    _log('📈 Total d\'utilisateurs: $count');

    // Chercher par email
    final userByEmail = db.getUserByEmail('josoa@lvlmind.com');
    if (userByEmail != null) {
      _log('✅ Utilisateur trouvé par email: ${userByEmail.name}');
    }

    // Chercher par nom
    final searchResults = db.searchUsersByName('Josoa');
    _log('🔍 Recherche "Josoa": ${searchResults.length} résultat(s)');
    for (final user in searchResults) {
      _log('   - ${user.name} (${user.matricule})');
    }

    // Obtenir les stats
    final stats = db.getDbStats();
    _log('📊 Stats:');
    _log('   Utilisateurs: ${stats['total_users']}');
    _log('   Connecté: ${stats['is_user_logged_in']}');
  }

  /// Exemple 10: Afficher tous les utilisateurs
  Future<void> _exampleShowAllUsers() async {
    _log('📋 Liste de tous les utilisateurs...');

    final db = appInit.localDbService;
    final allUsers = db.getAllUsers();

    _log('Total: ${allUsers.length} utilisateur(s)\n');
    for (final user in allUsers) {
      _log('👤 ${user.name}');
      _log('   Email: ${user.email}');
      _log('   Matricule: ${user.matricule}');
      _log('   Status: ${user.status}');
      _log('---');
    }
  }

  /// Nettoyer et réinitialiser
  Future<void> _exampleReset() async {
    _log('🔄 Réinitialisation de la base de données...');

    try {
      await appInit.resetDatabase();
      _log('✅ Base de données réinitialisée');
    } catch (e) {
      _log('❌ Erreur: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemples Hive'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Boutons d'exemples
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildButton('Enregistrer', _exampleRegister, Colors.blue),
                  _buildButton('Login OK', _exampleLoginSuccess, Colors.green),
                  _buildButton('Login KO', _exampleLoginFail, Colors.orange),
                  _buildButton('Utilisateur courant', _exampleGetLoggedInUser,
                      Colors.purple),
                  _buildButton(
                      'Maj profil', _exampleUpdateProfile, Colors.teal),
                  _buildButton(
                      'Changer pwd', _exampleChangePassword, Colors.indigo),
                  _buildButton('Réinit pwd', _exampleResetPassword, Colors.red),
                  _buildButton('Déconnecter', _exampleLogout, Colors.grey),
                  _buildButton(
                      'Opérations BD', _exampleDbOperations, Colors.brown),
                  _buildButton(
                      'Tous utilisateurs', _exampleShowAllUsers, Colors.cyan),
                  _buildButton('Réinit DB', _exampleReset, Colors.redAccent),
                ],
              ),
            ),
          ),

          // Output
          Expanded(
            child: Container(
              color: Colors.black87,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Text(
                  _output,
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontFamily: 'Courier New',
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    String label,
    VoidCallback onPressed,
    Color color,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 11),
      ),
    );
  }
}
