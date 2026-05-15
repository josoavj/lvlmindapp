<p align="center">
  <img src="https://github.com/josoavj/lvlmindapp/assets/76913187/5dda5a6a-5e5d-41e6-a818-17b853a7957f" alt="LevelMind Logo" width="150"/>
</p>

<h1 align="center">🎓 LevelMind</h1>

<p align="center">
  <strong>Une plateforme d'e-learning innovante pour les écoles et universités</strong>
</p>

<p align="center">
  <!-- Badges -->
  <img src="https://img.shields.io/badge/Flutter-%3E%3D3.1.0-blue?style=flat-square" alt="Flutter Version">
  <img src="https://img.shields.io/badge/Dart-%3E%3D3.1.0-blue?style=flat-square" alt="Dart Version">
  <img src="https://img.shields.io/badge/Version-1.0.0--beta.1-orange?style=flat-square" alt="Current Version">
  <img src="https://img.shields.io/badge/Status-Beta-yellow?style=flat-square" alt="Beta Status">
  <img src="https://img.shields.io/badge/license-MIT-green?style=flat-square" alt="License">
  <img src="https://img.shields.io/github/last-commit/josoavj/lvlmindapp?style=flat-square" alt="Last Commit">
</p>

---

## 📋 Table des Matières

- [📖 À Propos](#-à-propos)
- [✨ Fonctionnalités](#-fonctionnalités)
- [📊 État du Projet](#-état-du-projet)
- [🚀 Démarrage Rapide](#-démarrage-rapide)
  - [Prérequis](#prérequis)
  - [Installation](#installation)
  - [Première Utilisation](#première-utilisation)
- [🏗️ Architecture](#-architecture)
- [💾 Base de Données](#-base-de-données)
- [👤 Gestion de Compte](#-gestion-de-compte)
- [📦 Dépendances](#-dépendances)
- [🔄 Stratégie de Release](#-stratégie-de-release)
- [🧪 Tests](#-tests)
- [🐛 Signaler un Bug](#-signaler-un-bug)
- [🤝 Contribution](#-contribution)
- [👥 Équipe](#-équipe)
- [📄 Licence](#-licence)

---

## 📖 À Propos

**LevelMind** est une application mobile Flutter de nouvelle génération conçue pour révolutionner l'expérience d'apprentissage au sein des établissements scolaires et universitaires. Actuellement en **phase BETA**, elle vise à fournir un écosystème numérique complet et intuitif pour les étudiants et les enseignants.

### Objectifs Principaux

- 🎯 Centraliser toutes les ressources pédagogiques en un seul endroit
- 📱 Offrir une expérience mobile fluide et réactive
- 🔐 Garantir la sécurité et la confidentialité des données utilisateur
- 🌐 Faciliter la communication entre étudiants et enseignants
- 📈 Supporter la croissance avec une architecture scalable

---

## ✨ Fonctionnalités

### Actuellement Disponibles ✅

- **🔐 Authentification Complète**
  - Inscription de nouveaux utilisateurs
  - Connexion sécurisée avec hachage SHA256
  - Récupération de session automatique
  - Déconnexion avec suppression des données

- **👤 Gestion de Profil**
  - Affichage du profil utilisateur
  - Modification des informations personnelles
  - Persistence automatique des données

- **📚 Partage de Cours**
  - Accès aux supports de cours
  - Organisation hiérarchique par matière
  - Téléchargement hors-ligne (prévu)

- **🗓️ Emplois du Temps**
  - Visualisation de l'emploi du temps
  - Notifications des sessions à venir
  - Intégration calendrier (prévu)

- **💾 Stockage Local**
  - Base de données Hive intégrée
  - Persistance des données utilisateur
  - Synchronisation automatique

### En Développement 🚀

- 📢 Annonces et Actualités
- 💬 Messagerie entre utilisateurs
- 📊 Suivi de progression académique
- 📝 Système d'évaluation
- 🔔 Notifications push

---

## 📊 État du Projet

| Composant | État | Completude |
|-----------|------|-----------|
| Authentification | ✅ Stable | 100% |
| Gestion Utilisateur | ✅ Stable | 95% |
| UI/UX | 🚧 En cours | 80% |
| API Backend | 🚧 En cours | 0% |
| Tests Unitaires | 🚧 En cours | 30% |
| Documentation | ✅ À jour | 90% |
| Performances | ✅ Optimisé | 100% |
| Sécurité | ✅ Robuste | 85% |

---

## 🚀 Démarrage Rapide

### Prérequis

- **Flutter SDK**: [≥3.1.0](https://flutter.dev/docs/get-started/install)
- **Dart SDK**: ≥3.1.0 (inclus avec Flutter)
- **IDE**: Android Studio, VS Code ou IntelliJ IDEA
- **Git**: Pour cloner le dépôt
- **Android**: SDK ≥21 (pour le déploiement Android)
- **iOS**: iOS ≥12.0 (pour le déploiement iOS)

### Installation

#### 1️⃣ Cloner le dépôt

```bash
git clone https://github.com/josoavj/lvlmindapp.git
cd lvlmindapp
```

#### 2️⃣ Installer les dépendances

```bash
flutter pub get
```

#### 3️⃣ Générer les fichiers Hive

```bash
flutter pub run build_runner build
```

#### 4️⃣ Vérifier l'installation

```bash
flutter doctor
flutter analyze
```

### Première Utilisation

#### Option 1: Émulateur Android

```bash
flutter emulators --launch Pixel_4_API_30
flutter run
```

#### Option 2: Appareil iOS

```bash
open ios/Runner.xcworkspace
# Sélectionner votre appareil dans Xcode
flutter run
```

#### Option 3: Appareil Physique

```bash
# Brancher l'appareil en mode développeur
flutter run
```

### Comptes de Test

Utilisez ces identifiants pour tester l'application:

| Matricule | Mot de passe | Rôle | Établissement |
|-----------|--------------|------|---------------|
| 202301 | password123 | Étudiant | ISPM |
| 202302 | password123 | Étudiant | ISPM |
| 202303 | admin123 | Enseignant | ISPM |

**Ou créez votre propre compte** via la page d'inscription!

---

## 🏗️ Architecture

### Vue d'Ensemble

```
┌─────────────────────────────────────────────────────┐
│                  LevelMind App                      │
├─────────────────────────────────────────────────────┤
│ Couche Présentation (Pages & Widgets)               │
│  ├─ LoginPage / RegistrationPage                    │
│  ├─ HomePage / ProfilePage                          │
│  └─ SchedulePage / FilesPage                        │
├─────────────────────────────────────────────────────┤
│ Couche Métier (Providers & Services)                │
│  ├─ UserNotifier (State Management)                 │
│  ├─ ThemeNotifier (Gestion du thème)                │
│  ├─ EnhancedAuthService (Auth)                      │
│  └─ AppInitializationService (Init)                 │
├─────────────────────────────────────────────────────┤
│ Couche Données (Services & DB)                      │
│  ├─ LocalDbService (CRUD Hive)                      │
│  ├─ Hive Database (Local Storage)                   │
│  └─ UserProfile Model                               │
└─────────────────────────────────────────────────────┘
```

### Patterns Utilisés

- **MVVM**: Model-View-ViewModel avec Provider
- **Service Locator**: AppInitService (Singleton)
- **Observer**: Provider pour la réactivité
- **Repository**: LocalDbService pour l'accès aux données

### Structure des Dossiers

```
lib/
├── main.dart                 # Point d'entrée
├── screens/                  # Pages principales
│   ├── login_page.dart
│   ├── registration_page.dart
│   ├── profile_page.dart
│   └── ...
├── pages/                    # Pages secondaires
│   ├── home_page.dart
│   ├── schedule_page.dart
│   └── ...
├── Models/                   # Modèles de données
│   ├── user_profile.dart
│   ├── matiere.dart
│   └── ...
├── providers/                # State management
│   ├── user_notifier.dart
│   ├── theme_notifier.dart
│   └── ...
├── services/                 # Services métier
│   ├── enhanced_auth_service.dart
│   ├── local_db_service.dart
│   ├── app_initialization_service.dart
│   └── ...
├── navbar/                   # Navigation
│   ├── navbar.dart
│   └── transition.dart
├── animations/               # Animations
├── data/                     # Données statiques
└── json/                     # Fichiers de configuration
```

---

## 💾 Base de Données

### Hive Database

LevelMind utilise **Hive**, une base de données NoSQL légère et performante pour Flutter.

#### Boxes Disponibles

| Box | Contenu | Persistance |
|-----|---------|-------------|
| `users` | Tous les utilisateurs de l'app | ✅ Permanente |
| `session` | Utilisateur actuellement connecté | ⏳ Temporaire (effacé au logout) |

#### Initialisation

```dart
// Automatique au démarrage de l'app (AppInitService)
await AppInitService().initialize();
```

#### Opérations CRUD

```dart
// Ajouter un utilisateur
await appInit.db.addUser(userProfile);

// Récupérer un utilisateur
UserProfile? user = appInit.db.getUser('202301');

// Mettre à jour
await appInit.db.updateUser(updatedUser);

// Supprimer
await appInit.db.deleteUser('202301');

// Sauvegarder la session
await appInit.db.saveCurrentUser(user);

// Récupérer la session
UserProfile? current = appInit.db.getCurrentUser();
```

---

## 👤 Gestion de Compte

### Flux d'Authentification

#### Inscription

```
RegistrationPage → Validation → EnhancedAuthService.register()
    ↓
Hive.box("users").put(matricule, userProfile)
    ↓
✅ Compte créé → Auto-login → HomePage
```

#### Connexion

```
LoginPage → Validation → EnhancedAuthService.login()
    ↓
Verification mot de passe (SHA256)
    ↓
Hive.box("session").put("currentUser", user)
    ↓
UserNotifier.loadCurrentUser()
    ↓
✅ Session active → HomePage
```

#### Déconnexion

```
ProfilePage → Confirmation → UserNotifier.logout()
    ↓
Hive.box("session").delete("currentUser")
    ↓
EnhancedAuthService.logout()
    ↓
✅ Session effacée → WelcomePage
```

### Accès aux Données Utilisateur

#### Depuis n'importe quelle Page

```dart
// Lecture simple
final user = context.read<UserNotifier>().currentUser;

// Écouter les changements
Consumer<UserNotifier>(
  builder: (context, userNotifier, _) {
    return Text(userNotifier.currentUser?.name ?? 'Anonyme');
  }
)
```

---

## 📦 Dépendances

### Essentielles

```yaml
flutter:
  sdk: flutter
provider: ^6.1.5          # State management
hive: ^2.2.3              # Database local
hive_flutter: ^1.1.0      # Hive Flutter support
crypto: ^3.0.2            # SHA256 hashing
```

### UI/UX

```yaml
flutter_svg: ^2.0.9       # SVG rendering
google_fonts: ^6.1.0      # Google Fonts
iconsax_flutter: ^1.0.0   # Icons
cupertino_icons: ^1.0.2   # iOS icons
```

### Utilitaires

```yaml
shared_preferences: ^2.5.3 # Préférences locales
url_launcher: ^6.0.6       # Ouvrir des URLs
image_picker: ^1.0.4       # Sélectionner des images
video_player: ^2.8.1       # Lecture vidéo
```

### Dev Dependencies

```yaml
flutter_lints: ^6.0.0      # Analyse de code
build_runner: ^2.4.0       # Générateur de code
hive_generator: ^2.0.0     # Génération Hive
```

---

## 🔄 Stratégie de Release

### Versioning Semantique

Nous utilisons [Semantic Versioning 2.0.0](https://semver.org/):

```
MAJEURE.MINEURE.CORRECTIF+METADATA

1.0.0-beta.1  ← Première beta
1.0.0-beta.2  ← Deuxième beta
1.0.0-rc.1    ← Release Candidate
1.0.0         ← Release stable
1.1.0         ← Nouvelle mineure (features)
2.0.0         ← Nouvelle majeure (breaking changes)
```

### Plan de Release

#### Phase 1: BETA (Actuelle) 🟠

- **Version**: 1.0.0-beta.1 → 1.0.0-beta.5
- **Timeline**: Nov 2025 - Déc 2025
- **Focus**: Stabilisation auth & profil
- **Audience**: Testeurs internes
- **Platforms**: Android + iOS
- **Canaux**: 
  - Google Play (Beta Testing)
  - TestFlight (iOS)
  - GitHub Releases (APK direct)

#### Phase 2: RELEASE CANDIDATE 🟡

- **Version**: 1.0.0-rc.1 → 1.0.0-rc.3
- **Timeline**: Déc 2025 - Jan 2026
- **Focus**: Bug fixes, performance
- **Audience**: Testeurs externes
- **Validation**: Test coverage > 80%

#### Phase 3: STABLE 🟢

- **Version**: 1.0.0
- **Timeline**: Jan 2026
- **Focus**: Production-ready
- **Release Notes**: Complets
- **Support**: 1 an minimum

#### Phase 4: ÉVOLUTION 🚀

- **Version**: 1.1.0+, 2.0.0+
- **Timeline**: À partir de Jan 2026
- **Features**: Nouvelles fonctionnalités
- **Cadence**: Release tous les 2 mois

### Checklist Pre-Release

- [ ] Tous les tests passent (coverage > 80%)
- [ ] Pas d'erreurs `flutter analyze`
- [ ] Documentation mise à jour
- [ ] CHANGELOG mis à jour
- [ ] Version bumped dans pubspec.yaml
- [ ] Git tag créé
- [ ] Build APK/IPA testé
- [ ] Release notes rédigées

### Déploiement sur Google Play

```bash
# 1. Générer l'APK/AAB
flutter build appbundle --release

# 2. Signer l'APK
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 \
  -keystore ~/.android/release-key.jks \
  build/app/outputs/bundle/release/app-release.aab alias_name

# 3. Télécharger sur Google Play Console
# Suivre: https://developer.android.com/studio/publish

# 4. Déployer en BETA d'abord
# Settings → Release → Internal Testing → Upload APK → Review & Deploy
```

### Déploiement sur TestFlight (iOS)

```bash
# 1. Générer le build iOS
flutter build ios --release

# 2. Archiver dans Xcode
open ios/Runner.xcworkspace

# 3. Product → Archive → Upload

# 4. TestFlight → Add Beta Testers
```

---

## 🧪 Tests

### Tests Existants

```bash
# Lancer tous les tests
flutter test

# Tests avec coverage
flutter test --coverage
lcov --list coverage/lcov.info

# Tests spécifiques
flutter test test/unit/user_notifier_test.dart
flutter test test/integration/login_test.dart
```

### Types de Tests à Ajouter

- [ ] **Unitaires**: Services, Providers, Models
- [ ] **Widgets**: Pages, Widgets personnalisés
- [ ] **Intégration**: Flux complets (login → home)
- [ ] **Performance**: Mesure et optimization

---

## 🐛 Signaler un Bug

### Template de Bug Report

```markdown
## Description
[Description claire du bug]

## Étapes de Reproduction
1. [Étape 1]
2. [Étape 2]
3. [Bug observé]

## Comportement Attendu
[Ce qui devrait se passer]

## Environnement
- Version de l'app: 1.0.0-beta.1
- Plateforme: Android / iOS
- Appareil: [Marque + Modèle]
- Version OS: [Numéro]

## Logs/Screenshots
[Attachez les captures ou logs]
```

### Où Signaler

- 📧 Email: support@levelmind.app
- 💬 GitHub Issues: [Créer une issue](https://github.com/josoavj/lvlmindapp/issues)
- 📱 In-app: Menu → Aide → Signaler un problème

---

## 🤝 Contribution

Nous acceptons les contributions! Pour contribuer:

1. **Fork** le dépôt
2. **Créer une branche** pour votre feature (`git checkout -b feature/amazing-feature`)
3. **Commit** vos changements (`git commit -m 'Add amazing feature'`)
4. **Push** vers la branche (`git push origin feature/amazing-feature`)
5. **Ouvrir une Pull Request**

### Conventions de Code

```dart
// ✅ BON
void loginUser(String username, String password) {
  // Implementation
}

const int maxRetries = 3;

// ❌ MAUVAIS
void login_user(String username, String password) {
  // Implementation
}

const maxRetries = 3;
```

### Directives

- Respecter [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Ajouter des tests pour les nouvelles features
- Mettre à jour la documentation
- Vérifier `flutter analyze` (0 errors)
- Ajouter des commentaires pour la logique complexe

---

## 👥 Équipe

### Développement

- **Frontend Flutter**
  - [Josoa Rakotoarimanana](https://github.com/josoavj) - Lead Developer
  - [Fiatoa](https://github.com/foulburst) - Frontend Developer

### Design & UX

- **Design**
  - [Nyr Manamahefa](https://github.com/Manamahefa) - UI/UX Designer
  - [Koloina Koulié Nathalie](https://github.com/koulienathalie) - Designer

### Management

- **Project Manager**: [À compléter]
- **DevOps**: [À compléter]

### Comment Contacter

- 📧 support@levelmind.app
- 💬 Slack: #lvlmind-team
- 🐙 GitHub: [@josoavj](https://github.com/josoavj)

---

## 📄 Licence

Ce projet est sous licence **MIT**.

```
MIT License

Copyright (c) 2025 LevelMind Contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```

---

## 🙏 Remerciements

- [Flutter Team](https://flutter.dev) pour le framework remarquable
- [Hive Community](https://docs.hivedb.dev) pour la base de données
- Tous les contributeurs et testeurs

---

## 📚 Ressources Additionnelles

- 📖 [Documentation Architecture](./ARCHITECTURE_OVERVIEW.md)
- 🧪 [Guide des Tests](./TEST_GUIDE.md)
- 🚀 [Quick Start Guide](./QUICK_START.md)
- 📋 [Changelog Complet](./CHANGELOG.md)
- 🔐 [Politique de Sécurité](./SECURITY.md)

---

<div align="center">

**⭐ Si ce projet vous a été utile, n'hésitez pas à nous laisser une étoile!**

<a href="https://github.com/josoavj/lvlmindapp">
  <img src="https://img.shields.io/github/stars/josoavj/lvlmindapp?style=social" alt="Stars">
</a>

Made with ❤️ by the LevelMind Team

</div>
