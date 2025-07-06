class UserProfile {
  final String username;
  final String password;
  final String name;
  final String status;
  final String matricule;
  final String establishment;
  final String avatarPath; 

  UserProfile({
    required this.username,
    required this.password,
    required this.name,
    required this.status,
    required this.matricule,
    required this.establishment,
    required this.avatarPath,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
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
      password: '',
      name: json['name'] as String,
      status: json['status'] as String,
      matricule: json['matricule'] as String,
      establishment: json['establishment'] as String,
      avatarPath: json['avatarPath'] as String,
    );
  }
}