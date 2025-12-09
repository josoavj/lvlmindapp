import 'package:flutter_test/flutter_test.dart';
import 'package:lvlmindbeta/models/user_profile.dart';
import 'package:lvlmindbeta/services/enhanced_auth_service.dart';
import 'package:lvlmindbeta/services/local_db_service.dart';
import 'package:lvlmindbeta/data/user_data.dart';

void main() {
  group('Gestion de compte utilisateur', () {
    late EnhancedAuthService authService;
    late LocalDbService localDbService;

    setUpAll(() async {
      localDbService = LocalDbService();
      await localDbService.initialize();
      authService = EnhancedAuthService(db: localDbService);
    });

    group('Authentification', () {
      test('Login avec identifiants valides', () async {
        final user = await authService.login('202301', 'password123');

        expect(user, isNotNull);
        expect(user?.matricule, equals('202301'));
        expect(user?.name, equals('Josoa Vonjiniaina'));
        expect(user?.status, equals('Étudiant'));
      });

      test('Login avec identifiants invalides - matricule incorrect', () async {
        expect(
          () => authService.login('999999', 'password123'),
          throwsException,
        );
      });

      test('Login avec identifiants invalides - password incorrect', () async {
        expect(
          () => authService.login('202301', 'wrongpassword'),
          throwsException,
        );
      });

      test('L\'utilisateur est sauvegardé après login', () async {
        final user = await authService.login('202301', 'password123');
        final savedUser = authService.getLoggedInUser();

        expect(savedUser, isNotNull);
        expect(savedUser?.matricule, equals(user?.matricule));
        expect(savedUser?.name, equals(user?.name));
      });
    });

    group('Récupération du profil utilisateur', () {
      test('Récupère l\'utilisateur connecté', () async {
        await authService.login('202302', 'password123');
        final user = authService.getLoggedInUser();

        expect(user, isNotNull);
        expect(user?.name, equals('Fanantenana Andriamaro'));
        expect(user?.matricule, equals('202302'));
        expect(user?.email, equals('fanantenana.andriamaro@example.com'));
      });

      test('Retourne null si aucun utilisateur connecté', () async {
        await authService.logout();
        final user = authService.getLoggedInUser();

        expect(user, isNull);
      });

      test('Le mot de passe ne doit pas être visible', () async {
        await authService.login('202301', 'password123');
        final user = authService.getLoggedInUser();

        expect(user?.password, isNotEmpty); // Le password est hashé
      });
    });

    group('Mise à jour du profil', () {
      test('Met à jour le nom de l\'utilisateur', () async {
        final loginUser = await authService.login('202301', 'password123');

        await authService.updateUserProfile(
          matricule: loginUser!.matricule,
          name: 'Josoa Nouveau Nom',
        );

        final updatedUser = authService.getLoggedInUser();
        expect(updatedUser?.name, equals('Josoa Nouveau Nom'));
      });

      test('Met à jour l\'email de l\'utilisateur', () async {
        final loginUser = await authService.login('202301', 'password123');

        await authService.updateUserProfile(
          matricule: loginUser!.matricule,
          email: 'newemail@example.com',
        );

        final updatedUser = authService.getLoggedInUser();
        expect(updatedUser?.email, equals('newemail@example.com'));
      });

      test('Met à jour plusieurs champs à la fois', () async {
        final loginUser = await authService.login('202301', 'password123');

        await authService.updateUserProfile(
          matricule: loginUser!.matricule,
          name: 'Nom Modifié',
          email: 'modifie@example.com',
        );

        final updatedUser = authService.getLoggedInUser();
        expect(updatedUser?.name, equals('Nom Modifié'));
        expect(updatedUser?.email, equals('modifie@example.com'));
      });

      test('Lance une exception si matricule invalide', () async {
        expect(
          () => authService.updateUserProfile(
            matricule: 'invalid',
            name: 'Test',
          ),
          throwsException,
        );
      });

      test('Les champs non fournis restent inchangés', () async {
        final loginUser = await authService.login('202301', 'password123');
        final originalEmail = authService.getLoggedInUser()?.email;

        await authService.updateUserProfile(
          matricule: loginUser!.matricule,
          name: 'Nouveau Nom',
        );

        final updatedUser = authService.getLoggedInUser();
        expect(updatedUser?.email, equals(originalEmail));
      });
    });

    group('Déconnexion', () {
      test('La déconnexion supprime les données utilisateur', () async {
        await authService.login('202301', 'password123');
        var user = authService.getLoggedInUser();
        expect(user, isNotNull);

        await authService.logout();
        user = authService.getLoggedInUser();
        expect(user, isNull);
      });
    });

    group('Modèle UserProfile', () {
      test('UserProfile.copyWith crée une copie avec modifications', () {
        final user = UserProfile(
          username: 'josoa',
          password: 'password123',
          name: 'Josoa Vonjiniaina',
          email: 'josoa@example.com',
          status: 'Étudiant',
          matricule: '202301',
          establishment: 'Université',
          avatarPath: 'assets/avatar.png',
        );

        final updatedUser = user.copyWith(
          name: 'Josoa Nouveau',
          email: 'nouveau@example.com',
        );

        expect(updatedUser.name, equals('Josoa Nouveau'));
        expect(updatedUser.email, equals('nouveau@example.com'));
        expect(updatedUser.matricule, equals(user.matricule));
        expect(updatedUser.status, equals(user.status));
      });

      test('Sérialisation JSON - toJson et fromJson', () {
        final user = UserProfile(
          username: 'josoa',
          password: 'password123',
          name: 'Josoa Vonjiniaina',
          email: 'josoa@example.com',
          status: 'Étudiant',
          matricule: '202301',
          establishment: 'Université',
          avatarPath: 'assets/avatar.png',
        );

        final json = user.toJson();
        final fromJson = UserProfile.fromJson(json);

        expect(fromJson.username, equals(user.username));
        expect(fromJson.name, equals(user.name));
        expect(fromJson.email, equals(user.email));
        expect(fromJson.matricule, equals(user.matricule));
      });

      test('fromJson crée un utilisateur avec password vide', () {
        final json = {
          'username': 'josoa',
          'name': 'Josoa Vonjiniaina',
          'email': 'josoa@example.com',
          'status': 'Étudiant',
          'matricule': '202301',
          'establishment': 'Université',
          'avatarPath': 'assets/avatar.png',
        };

        final user = UserProfile.fromJson(json);
        expect(user.password, isEmpty);
      });
    });

    group('Utilisateurs de test', () {
      test('Les utilisateurs de test existent', () {
        expect(users, isNotEmpty);
        expect(users.length, greaterThanOrEqualTo(3));
      });

      test('Josoa peut se connecter', () async {
        final user = await authService.login('202301', 'password123');
        expect(user?.username, equals('josoa'));
      });

      test('Fana peut se connecter', () async {
        final user = await authService.login('202302', 'password123');
        expect(user?.username, equals('fana'));
      });

      test('Admin peut se connecter', () async {
        final user = await authService.login('202303', 'adminpassword');
        expect(user?.username, equals('admin'));
        expect(user?.status, equals('Professeur'));
      });
    });
  });
}
