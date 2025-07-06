import '../Models/userProfile.dart';

final List<UserProfile> users = [
  UserProfile(
    username: 'josoa',
    password: 'password123',
    name: 'Josoa Vonjiniaina',
    status: 'Étudiant',
    matricule: 'LM2023001',
    establishment: 'Université d\'Antananarivo',
    avatarPath: 'assets/images/profil_placeholder.png',
  ),
  UserProfile(
    username: 'fana',
    password: 'password123',
    name: 'Fanantenana Andriamaro',
    status: 'Étudiant',
    matricule: 'LM2023002', // Vérifiez ce matricule
    establishment: 'ESPA Vontovorona',
    avatarPath: 'assets/images/profil_placeholder_fana.png',
  ),
  UserProfile(
    username: 'admin',
    password: 'adminpassword',
    name: 'Administrateur Test',
    status: 'Professeur',
    matricule: 'LM2023003', // Vérifiez ce matricule
    establishment: 'LVLMIND Academy',
    avatarPath: 'assets/images/profil_placeholder_admin.png',
  ),
];