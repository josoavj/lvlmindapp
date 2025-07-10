class UserProfile {
  final String username;
  final String password; // Garder le mot de passe dans l'objet pour la logique interne si besoin, mais ne pas le sérialiser directement pour la persistance locale si non nécessaire.
  final String name;
  final String email;
  final String status;
  final String matricule;
  final String establishment;
  final String avatarPath;


  UserProfile({
    required this.username,
    required this.password,
    required this.name,
    required this.email,
    required this.status,
    required this.matricule,
    required this.establishment,
    required this.avatarPath,
  });

  // Convertit un objet UserProfile en un Map (utile pour la sauvegarde JSON)
  // Incluez l'email ici pour qu'il soit sauvegardé.
  // N'incluez PAS le mot de passe pour des raisons de sécurité évidentes avec SharedPreferences.
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      // 'password': password, // Ne PAS inclure le mot de passe pour la persistance locale simple
      'name': name,
      'email': email, // Assurez-vous que l'email est inclus
      'status': status,
      'matricule': matricule,
      'establishment': establishment,
      'avatarPath': avatarPath,
    };
  }

  // Méthode pour créer un UserProfile à partir d'une Map (pour SharedPreferences)
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'] as String,
      password: '', // Le mot de passe ne doit PAS être stocké ici ou dans SharedPreferences pour des raisons de sécurité. Il devrait être vérifié via un backend.
      name: json['name'] as String,
      email: json['email'] as String, // Récupérez l'email ici
      status: json['status'] as String,
      matricule: json['matricule'] as String,
      establishment: json['establishment'] as String,
      avatarPath: json['avatarPath'] as String,
    );
  }

  // Méthode copyWith pour créer une nouvelle instance avec des valeurs mises à jour.
  // Ceci est très utile pour les objets immuables comme UserProfile.
  UserProfile copyWith({
    String? username,
    String? password,
    String? name,
    String? email,
    String? status,
    String? matricule,
    String? establishment,
    String? avatarPath,
  }) {
    return UserProfile(
      username: username ?? this.username,
      password: password ?? this.password, // À utiliser avec précaution si le mot de passe n'est pas géré via ce flux
      name: name ?? this.name,
      email: email ?? this.email,
      status: status ?? this.status,
      matricule: matricule ?? this.matricule,
      establishment: establishment ?? this.establishment,
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }
}