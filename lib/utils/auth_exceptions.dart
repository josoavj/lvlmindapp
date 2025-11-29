/// Exceptions personnalisées pour l'authentification
class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() => message;
}

/// Classe pour les erreurs d'authentification
class AuthError {
  static const String invalidCredentials =
      'Numéro de matricule ou mot de passe incorrect.';
  static const String connectionError =
      'Une erreur est survenue lors de la connexion.';
  static const String noUserLoggedIn = 'Aucun utilisateur connecté.';
  static const String updateError =
      'Une erreur est survenue lors de la mise à jour du profil.';
}
