import '../models/user_profile.dart';

final List<UserProfile> users = [
  UserProfile(
    username: 'josoa',
    password: 'password123',
    name: 'Josoa Vonjiniaina',
    email: 'josoa.vonjiniaina@example.com', // Ajout d'un email pour l'exemple
    status: 'Étudiant',
    matricule: '202301',
    establishment: 'Université d\'Antananarivo',
    avatarPath: 'assets/images/profil_placeholder.png',
  ),
  UserProfile(
    username: 'fana',
    password: 'password123',
    name: 'Fanantenana Andriamaro',
    email: 'fanantenana.andriamaro@example.com', // Ajout d'un email
    status: 'Étudiant',
    matricule: '202302',
    establishment: 'ESPA Vontovorona',
    avatarPath: 'assets/images/profil_placeholder_fana.png',
  ),
  UserProfile(
    username: 'admin',
    password: 'adminpassword',
    name: 'Administrateur Test',
    email: 'admin@lvlmind.com', // Ajout d'un email
    status: 'Professeur',
    matricule: '202303',
    establishment: 'LVLMIND Academy',
    avatarPath: 'assets/images/profil_placeholder_admin.png',
  ),
];
