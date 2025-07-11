class UserProfile {
  final String username;
  final String password;
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

  Map<String, dynamic> toJson() => {
    'username': username,
    'name': name,
    'email': email, // Assurez-vous que l'email est ici !
    'status': status,
    'matricule': matricule,
    'establishment': establishment,
    'avatarPath': avatarPath,
  };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    username: json['username'] as String,
    password: '', // Le mot de passe ne doit pas être récupéré de SharedPreferences
    name: json['name'] as String,
    email: json['email'] as String, // Assurez-vous que l'email est récupéré ici !
    status: json['status'] as String,
    matricule: json['matricule'] as String,
    establishment: json['establishment'] as String,
    avatarPath: json['avatarPath'] as String,
  );

  // Assurez-vous que cette méthode est présente et correcte
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
      password: password ?? this.password,
      name: name ?? this.name,
      email: email ?? this.email,
      status: status ?? this.status,
      matricule: matricule ?? this.matricule,
      establishment: establishment ?? this.establishment,
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }
}