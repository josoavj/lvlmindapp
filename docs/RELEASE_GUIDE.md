# 📦 Guide Complet de Release - LevelMind

Ce document fournit un processus étape par étape pour créer et déployer des releases de LevelMind.

---

## 📋 Table des Matières

1. [Stratégie de Release](#stratégie-de-release)
2. [Versioning](#versioning)
3. [Processus Pre-Release](#processus-pre-release)
4. [Création d'une Release](#création-dune-release)
5. [Déploiement Platforms](#déploiement-platforms)
6. [Post-Release](#post-release)
7. [Outils & Ressources](#outils--ressources)
8. [Checklist Complète](#checklist-complète)

---

## Stratégie de Release

### Timeline Proposée

```
BETA Phase (Nov-Dec 2025)
├─ 1.0.0-beta.1 : Authentification stable
├─ 1.0.0-beta.2 : Integration features
├─ 1.0.0-beta.3 : Bug fixes & optimization
├─ 1.0.0-beta.4 : Performance tuning
└─ 1.0.0-beta.5 : Final stability

RC Phase (Dec 2025-Jan 2026)
├─ 1.0.0-rc.1 : Release candidate 1
├─ 1.0.0-rc.2 : Bug fixes from RC1
└─ 1.0.0-rc.3 : Final production checks

STABLE (Jan 2026)
└─ 1.0.0 : First production release

EVOLUTION (From Jan 2026)
├─ 1.1.0 : Minor features & fixes (Q1 2026)
├─ 1.2.0 : More features (Q2 2026)
├─ 1.5.0 : Significant additions (by Q3)
└─ 2.0.0 : Major overhaul (by Q4)
```

### Fréquence

- **Beta**: Chaque 1-2 semaines
- **RC**: Chaque semaine
- **Stable**: Première 1.0.0 en Jan 2026
- **Minor**: Tous les 2 mois après (1.1.0, 1.2.0, etc.)
- **Hotfix**: À la demande (1.0.1, 1.1.1, etc.)

---

## Versioning

### Format Semantique

```
MAJEURE.MINEURE.CORRECTIF-PRERELEASE+BUILD

Exemple:
1.0.0-beta.1    → Version beta
1.0.0-rc.1      → Release candidate
1.0.0           → Production
1.1.0           → Nouvelle mineure
2.0.0           → Nouvelle majeure
1.0.1           → Correctif
```

### Où Changer la Version

#### 1. `pubspec.yaml`

```yaml
version: 1.0.0-beta.1+1
# MAJEURE.MINEURE.CORRECTIF-PRERELEASE+BUILD
```

#### 2. `android/app/build.gradle`

```gradle
android {
    defaultConfig {
        versionCode 1         // Incrementer (+1 à chaque build)
        versionName "1.0.0-beta.1"
    }
}
```

#### 3. `ios/Runner/Info.plist`

```xml
<key>CFBundleShortVersionString</key>
<string>1.0.0-beta.1</string>
<key>CFBundleVersion</key>
<string>1</string>
```

---

## Processus Pre-Release

### 1️⃣ Planification (1 semaine avant)

#### Créer une issue de release

```markdown
## Release: 1.0.0-beta.2

### Focus
- [ ] Features à inclure
- [ ] Bugs à fixer
- [ ] Tests à valider

### Timeline
- Start: 2025-12-06
- Code freeze: 2025-12-12
- Testing: 2025-12-12 to 2025-12-15
- Deploy: 2025-12-20

### Owner
@josoavj
```

#### Créer une branche release

```bash
git checkout -b release/1.0.0-beta.2
```

### 2️⃣ Développement (1-2 semaines)

```bash
# Travailler sur la branche
git commit -m "feat: new feature for beta.2"
git commit -m "fix: critical bug"
git commit -m "docs: update README"
```

### 3️⃣ Stabilisation (2-3 jours avant)

#### Geler le code

```bash
# Plus de nouvelles features
# Seulement des bug fixes et docs
git commit -m "fix: critical bug for beta.2"
```

#### Vérifier les dépendances

```bash
flutter pub get
flutter pub outdated
flutter pub upgrade --dry-run
```

#### Nettoyer le code

```bash
flutter analyze          # 0 errors expected
dart format lib/        # Formater le code
```

#### Tester manuellement

```bash
flutter run -v          # Tester sur Android
flutter run -d macos   # Tester sur iOS

# Check list:
# ✅ Login works
# ✅ Registration works
# ✅ Profile loads
# ✅ No crashes
# ✅ Performance OK
```

### 4️⃣ Préparation Release

#### Mettre à jour pubspec.yaml

```yaml
version: 1.0.0-beta.2+2
```

#### Mettre à jour CHANGELOG

```markdown
## [1.0.0-beta.2] - 2025-12-20

### ✨ Ajouté
- Feature 1
- Feature 2

### 🔧 Amélioré
- Performance improvement
- UX enhancement

### 🐛 Corrigé
- Bug 1
- Bug 2

### 📝 Documenté
- Updated README
```

#### Mettre à jour README

```markdown
## Status
🟠 Beta v1.0.0-beta.2
```

#### Version commit

```bash
git add pubspec.yaml CHANGELOG.md README.md
git commit -m "chore: bump version to 1.0.0-beta.2"
git tag -a v1.0.0-beta.2 -m "Release version 1.0.0-beta.2"
git push origin release/1.0.0-beta.2
git push origin v1.0.0-beta.2
```

---

## Création d'une Release

### Étape 1: Générer les Builds

#### Android - APK

```bash
# Clean
flutter clean

# Build APK Release
flutter build apk --release \
  --build-number=$(date +%s)

# Resultat: build/app/outputs/flutter-app.apk
ls -lh build/app/outputs/flutter-app.apk
```

#### Android - Bundle (Google Play)

```bash
# Build AAB
flutter build appbundle --release

# Resultat: build/app/outputs/bundle/release/app-release.aab
ls -lh build/app/outputs/bundle/release/app-release.aab
```

#### iOS

```bash
# Clean
flutter clean

# Build iOS Release
flutter build ios --release

# Archive in Xcode
open ios/Runner.xcworkspace

# Dans Xcode:
# Product → Archive → Validate → Distribute

# Resultat: .xcarchive et .ipa
```

### Étape 2: Tests de Build

#### Vérifier les fichiers

```bash
# Android
file build/app/outputs/flutter-app.apk
# Resultat: Zip archive data

# iOS
file build/ios/iphoneos/Runner.app
# Resultat: directory
```

#### Tester sur appareil

```bash
# Installer APK
adb install build/app/outputs/flutter-app.apk

# Tester l'app
# ✅ Démarrage sans erreur
# ✅ Authentification OK
# ✅ Pas de crashes
# ✅ Performance stable
```

### Étape 3: Signer les Binaires

#### Android Signing

**Créer une clé de signature (première fois)**

```bash
keytool -genkey -v -keystore \
  ~/.android/release-key.jks \
  -keyalg RSA -keysize 2048 \
  -validity 10000 \
  -alias lvlmind_key

# Répondre aux questions:
# Nom: Josoa Rakotoarimanana
# Organisation: LevelMind
# Localité: Antananarivo
# État: Antananarivo
# Code pays: MG
```

**Signer l'APK**

```bash
jarsigner -verbose \
  -sigalg SHA256withRSA \
  -digestalg SHA-256 \
  -keystore ~/.android/release-key.jks \
  build/app/outputs/flutter-app.apk \
  lvlmind_key

# Entrer le mot de passe
```

**Aligner l'APK (optionnel mais recommandé)**

```bash
zipalign -v 4 \
  build/app/outputs/flutter-app.apk \
  build/app/outputs/lvlmind-1.0.0-beta.2.apk
```

#### iOS Signing

- Utiliser Xcode (automatique avec certificat)
- Ou utiliser fastlane (avancé)

### Étape 4: Créer la Release sur GitHub

```bash
# Créer la release
gh release create v1.0.0-beta.2 \
  --title "Version 1.0.0-beta.2" \
  --notes "Voir CHANGELOG.md pour les détails" \
  build/app/outputs/lvlmind-1.0.0-beta.2.apk

# Ou manuellement sur GitHub.com
# Releases → Draft a new release → v1.0.0-beta.2
```

---

## Déploiement Platforms

### Google Play (Android)

#### Configuration Initiale (une fois)

1. **Créer un compte Google Play Developer**
   - Aller à [Google Play Console](https://play.google.com/console)
   - Inscription 25 USD

2. **Créer l'app**
   - Play Console → Créer une application
   - Remplir les détails

3. **Créer une clé de signature**
   - (Voir étape 3 ci-dessus)

4. **Créer des tracks**
   - Internal Testing
   - Closed Testing
   - Open Testing
   - Production

#### Déploiement Beta

```bash
# 1. Accéder à Play Console
open https://play.google.com/console

# 2. Sélectionner votre app

# 3. Aller à: Releases → Internal Testing (ou Closed Testing)

# 4. Cliquer "Create new release"

# 5. Upload le fichier .aab
# Fichier: build/app/outputs/bundle/release/app-release.aab

# 6. Remplir:
# - Release notes (français + anglais)
# - Privacy policy link
# - Rating (PEGI, etc.)

# 7. Review → Publish

# Timeline: 30 min - 2h pour l'activation
```

#### Promotion vers Stable

```
Internal Testing (testeurs internes)
        ↓
Closed Testing (testeurs externes)
        ↓
Open Testing (beta public)
        ↓
Production (grand public)
```

### TestFlight (iOS)

#### Configuration Initiale

1. **Accéder à App Store Connect**
   - <https://appstoreconnect.apple.com>

2. **Créer l'app**
   - Apps → Ajouter une nouvelle app

3. **Setup TestFlight**
   - TestFlight → Testers → Ajouter des testeurs

#### Déploiement Beta

```bash
# 1. Build dans Xcode
open ios/Runner.xcworkspace

# 2. Sélectionner Runner
# 3. General → Version: 1.0.0-beta.2, Build: 2

# 4. Product → Archive

# 5. Dans l'organizer:
# Archives → Validate → Distribute App

# 6. Sélectionner:
# TestFlight and the App Store → TestFlight only

# 7. Signer avec votre certificat

# 8. Attendre l'upload et le traitement

# Timeline: 30 min - 1h pour l'activation
```

### GitHub Releases

```bash
# Créer une release GitHub
git push origin v1.0.0-beta.2

# Sur GitHub.com:
# Releases → Create release from tag

# Remplir:
# - Title: Version 1.0.0-beta.2
# - Description: Voir CHANGELOG.md
# - Attachments: APK/AAB
# - Pre-release: ✅ (pour beta)

# Publish
```

---

## Post-Release

### 1️⃣ Communication (jour de release)

#### Annoncer la release

```markdown
## 🎉 LevelMind 1.0.0-beta.2 is Live!

### What's New
- ✨ New feature 1
- ✨ New feature 2
- 🐛 Fixed bug 1
- 🐛 Fixed bug 2

### Download
- Android: [Google Play](link)
- iOS: [TestFlight](link)
- APK Direct: [GitHub](link)

### Feedback
Report issues at: https://github.com/josoavj/lvlmindapp/issues

### Timeline for Next Release
1.0.0-beta.3: December 30, 2025
```

#### Postes sur

- 📱 GitHub (Release notes)
- 📧 Email: <support@levelmind.app>
- 💬 Slack: #announcements
- 🐙 GitHub Discussions
- 📊 Twitter/X (si applicable)

### 2️⃣ Monitoring (1 semaine après)

```bash
# Vérifier les crash reports
# Google Play Console → Vitals → Crashes

# Vérifier les reviews
# Google Play Console → Reviews → Read reviews

# Monitorer les issues
# GitHub Issues → Filter: bug + this version
```

#### Seuils de tolérance

- Crash rate: < 0.5%
- ANR rate: < 0.1%
- Bugs critiques reportés: 0-2 acceptable
- Hotfix si: > 5 bugs critiques

### 3️⃣ Hotfix (si nécessaire)

```bash
# Si bug critique trouvé:

git checkout -b hotfix/1.0.0-beta.2.1
# Corriger le bug
git commit -m "fix: critical bug in 1.0.0-beta.2"

# Bump version
pubspec.yaml: 1.0.0-beta.2.1+3

# Tag et release
git tag v1.0.0-beta.2.1
git push origin hotfix/1.0.0-beta.2.1
git push origin v1.0.0-beta.2.1

# Déployer (voir étapes ci-dessus)
```

### 4️⃣ Retrospective (2 semaines après)

```markdown
## Release 1.0.0-beta.2 Retrospective

### Metrics
- Users: X
- Crash rate: X%
- Bugs reported: X
- Session duration: X min
- Retention rate: X%

### What went well
- ✅ Item 1
- ✅ Item 2

### What could improve
- 🔄 Item 1
- 🔄 Item 2

### Action items
- [ ] Action 1
- [ ] Action 2

### Date next planning session
2025-12-20
```

---

## Outils & Ressources

### Outils Essentiels

```bash
# Vérification de code
flutter analyze         # Lint checking
dart format lib/       # Code formatting
flutter test           # Run tests

# Building
flutter build apk --release      # Android APK
flutter build appbundle --release # Android AAB
flutter build ios --release      # iOS

# Signing
keytool                # Create keys
jarsigner              # Sign APKs
zipalign               # Optimize APK

# Version Management
git tag -l             # List tags
git tag -a             # Create annotated tag
git push --tags        # Push all tags
```

### Services de Déploiement

| Service | Android | iOS | Prix |
|---------|---------|-----|------|
| **Google Play** | ✅ | ❌ | $25/app |
| **App Store** | ❌ | ✅ | $99/year |
| **TestFlight** | ❌ | ✅ | Free |
| **Firebase** | ✅ | ✅ | Free-$299 |
| **GitHub** | ✅ | ✅ | Free |

### Documentation Utile

- [Semantic Versioning](https://semver.org/)
- [Google Play Console Help](https://support.google.com/googleplay/)
- [App Store Connect Help](https://support.apple.com/en-us/ase)
- [Flutter Build Documentation](https://flutter.dev/docs/deployment)
- [Fastlane Documentation](https://docs.fastlane.tools/)

---

## Checklist Complète

### ✅ Avant la Release (1 semaine)

#### Code Freeze

- [ ] Plus de nouvelles features
- [ ] Seulement bug fixes et documentation

#### Validation

- [ ] `flutter analyze` = 0 errors
- [ ] `flutter test` = tous passent
- [ ] `dart format` = formaté
- [ ] Pas d'erreurs de déploiement

#### Vérification Manuelle

- [ ] Tester la connexion
- [ ] Tester l'inscription
- [ ] Tester le profil
- [ ] Tester la déconnexion
- [ ] Tester sur Android
- [ ] Tester sur iOS
- [ ] Vérifier la performance

#### Documentation

- [ ] CHANGELOG mis à jour
- [ ] README mis à jour
- [ ] Release notes rédigées
- [ ] API docs à jour

#### Dépendances

- [ ] `flutter pub get` OK
- [ ] Pas de vulnérabilités connues
- [ ] Dépendances compatibles

### ✅ Jour de la Release

#### Builds

- [ ] Android APK généré
- [ ] Android AAB généré
- [ ] iOS build généré
- [ ] Fichiers signés

#### Tests de Builds

- [ ] APK testable sur appareil
- [ ] IPA testable sur iPhone
- [ ] Pas de crashes au démarrage
- [ ] Authentification fonctionne

#### Versioning

- [ ] pubspec.yaml bumped
- [ ] android/app/build.gradle bumped
- [ ] ios/Runner/Info.plist bumped
- [ ] CHANGELOG mis à jour

#### Git

- [ ] Commit: "chore: bump version to X.Y.Z"
- [ ] Tag créé: vX.Y.Z
- [ ] Push vers origin
- [ ] Push des tags

#### Déploiement

- [ ] Google Play: APK/AAB uploadé
- [ ] TestFlight: IPA uploadé
- [ ] GitHub: Release créée
- [ ] GitHub: APK en attachment

#### Communication

- [ ] Annoncement rédigé
- [ ] Email envoyé
- [ ] Slack notifié
- [ ] GitHub discussions créée

### ✅ Après la Release (1 semaine)

#### Monitoring

- [ ] Vérifier Google Play Console
- [ ] Vérifier TestFlight
- [ ] Lire les reviews
- [ ] Regarder les crash reports

#### Feedback

- [ ] Répondre aux questions
- [ ] Triage des bugs reportés
- [ ] Planifier des hotfixes si nécessaire

#### Documentation

- [ ] Mise à jour des tutoriels
- [ ] Mise à jour des docs
- [ ] Screenshots mis à jour

#### Planification

- [ ] Planifier la prochaine release
- [ ] Ajouter les features pour beta+1
- [ ] Créer les issues
- [ ] Assigner à des personnes

---

## Exemple Complet: Release 1.0.0-beta.2

### Jour 1: Planification

```bash
git checkout -b release/1.0.0-beta.2
# Travailler sur les features
```

### Jour 8: Code Freeze

```bash
flutter analyze      # ✅ 0 errors
flutter test        # ✅ Tous passent
git add -A
git commit -m "fix: final bugs for beta.2"
```

### Jour 9: Versioning

```bash
# Mettre à jour les versions
vim pubspec.yaml    # 1.0.0-beta.2+2
vim CHANGELOG.md    # Ajouter entry
vim README.md       # Mettre à jour status

git add -A
git commit -m "chore: bump version to 1.0.0-beta.2"
git tag -a v1.0.0-beta.2 -m "Release 1.0.0-beta.2"
```

### Jour 10: Builds

```bash
flutter clean
flutter build apk --release
flutter build appbundle --release
flutter build ios --release

# Signer les fichiers
jarsigner -keystore ~/.android/release-key.jks \
  build/app/outputs/flutter-app.apk lvlmind_key
```

### Jour 11: Tests

```bash
adb install build/app/outputs/flutter-app.apk
# Tester l'app complètement
# ✅ Login: OK
# ✅ Register: OK
# ✅ Profile: OK
# ✅ No crashes: OK
```

### Jour 12: Déploiement

```bash
# Google Play
open https://play.google.com/console
# Upload AAB vers Internal Testing

# TestFlight
open https://appstoreconnect.apple.com
# Upload via Xcode

# GitHub
git push origin v1.0.0-beta.2
gh release create v1.0.0-beta.2 \
  build/app/outputs/lvlmind-1.0.0-beta.2.apk
```

### Jour 13: Annonce

```
Email + Slack + GitHub:
"🎉 LevelMind 1.0.0-beta.2 released!
Features: X, Y, Z
Bug fixes: A, B, C
Download: [links]"
```

---

## Support & Questions

- 📧 <support@levelmind.app>
- 💬 GitHub Issues
- 🐙 GitHub Discussions
- 📱 In-app help

---

**Last Updated**: 2025-11-29  
**Version**: 1.0.0  
**Maintainer**: @josoavj
