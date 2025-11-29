# 🎯 Quick Start - Première Release Beta

Ce document vous guide pour créer votre première release en beta.

---

## 📋 Résumé Rapide

```bash
# 1. Vérifier l'environnement
./release.sh check

# 2. Nettoyer
./release.sh clean

# 3. Installer les dépendances
./release.sh deps

# 4. Tester
./release.sh test

# 5. Mettre à jour la version
./release.sh version 1.0.0-beta.1

# 6. Créer les builds
./release.sh build 1.0.0-beta.1

# 7. Signer l'APK
./release.sh sign

# 8. Créer le tag Git
./release.sh tag 1.0.0-beta.1

# 9. Vérifier le statut
./release.sh status
```

**Temps total: ~30-45 minutes** ⏱️

---

## 1️⃣ Vérifier l'Environnement

```bash
./release.sh check
```

**Expected Output:**
```
ℹ Flutter: Flutter 3.19.x
ℹ Dart: Dart SDK version 3.x
ℹ Git: git version 2.x
ℹ Android SDK: Found
✓ Flutter analyze: OK
```

**Si erreurs:** Installez Flutter depuis https://flutter.dev

---

## 2️⃣ Nettoyer les Build Précédents

```bash
./release.sh clean
```

**Résultat:** Supprime les dossiers `build/`, `.dart_tool/`, etc.

---

## 3️⃣ Installer les Dépendances

```bash
./release.sh deps
```

**Résultat:** Installe les packages et génère le code Hive

---

## 4️⃣ Tester l'Application

```bash
./release.sh test
```

**Attendu:**
- ✅ Tous les tests passent
- ✅ Coverage > 30%
- ✅ Pas d'erreurs

---

## 5️⃣ Mettre à Jour la Version

```bash
./release.sh version 1.0.0-beta.1
```

**Fichiers modifiés:**
- `pubspec.yaml`: `1.0.0-beta.1+1`
- `android/app/build.gradle`: versionCode=1, versionName="1.0.0-beta.1"
- `ios/Runner/Info.plist`: CFBundleShortVersionString="1.0.0-beta.1"

**Vérifier:**
```bash
grep "version:" pubspec.yaml
# Output: version: 1.0.0-beta.1+1
```

---

## 6️⃣ Créer les Builds

```bash
./release.sh build 1.0.0-beta.1
```

**Builds créés:**
- ✅ `build/app/outputs/flutter-app.apk` (~50MB)
- ✅ `build/app/outputs/bundle/release/app-release.aab` (~45MB)
- ✅ `build/ios/iphoneos/Runner.app` (dossier)

**Tester l'APK:**
```bash
adb install build/app/outputs/flutter-app.apk
# Tester manuellement sur appareil/émulateur
```

---

## 7️⃣ Signer l'APK

### Première Fois: Créer la Keystore

```bash
keytool -genkey -v -keystore \
  ~/.android/release-key.jks \
  -keyalg RSA -keysize 2048 \
  -validity 10000 \
  -alias lvlmind_key
```

**Répondre à:**
```
Keystore password: [VOTRE_MOT_DE_PASSE]
Re-enter password: [CONFIRMATION]
First and last name: Josoa Rakotoarimanana
Organizational Unit: Development
Organization: LevelMind
City or Locality: Antananarivo
State or Province: Antananarivo
Two-letter Country Code: MG
```

### Signer l'APK

```bash
./release.sh sign
```

**Résultat:** APK signé et optionnellement aligné

---

## 8️⃣ Créer le Tag Git

```bash
# Commit les changements de version
git add pubspec.yaml android/app/build.gradle ios/Runner/Info.plist
git commit -m "chore: bump version to 1.0.0-beta.1"

# Créer le tag
./release.sh tag 1.0.0-beta.1

# Vérifier le tag
git tag -l
# Output: v1.0.0-beta.1
```

---

## 9️⃣ Vérifier le Statut

```bash
./release.sh status
```

**Expected Output:**
```
ℹ Current version: 1.0.0-beta.1+1
ℹ Latest tag: v1.0.0-beta.1
✓ Working directory clean
ℹ APK: 50M
ℹ AAB: 45M
```

---

## 🚀 Déployer sur les Platforms

### Google Play Beta

**Manuel:**
1. Aller à [Google Play Console](https://play.google.com/console)
2. Sélectionner l'app
3. Releases → Internal Testing
4. Create new release
5. Upload `build/app/outputs/bundle/release/app-release.aab`
6. Remplir:
   - Release notes: "Première version BETA avec authentification"
   - Version: 1.0.0-beta.1
7. Publish

**Timeline:** 30 min - 2h

### TestFlight (iOS)

**Manuel:**
1. Ouvrir `ios/Runner.xcworkspace` dans Xcode
2. Sélectionner Runner
3. General → Version: 1.0.0-beta.1, Build: 1
4. Product → Archive
5. Distribute App → TestFlight
6. Signer et upload

**Timeline:** 30 min - 1h

### GitHub Release

```bash
# Créer automatiquement
gh release create v1.0.0-beta.1 \
  --title "Version 1.0.0-beta.1 - First Beta" \
  --notes "First beta release with authentication system" \
  build/app/outputs/flutter-app.apk

# Ou manuellement sur GitHub.com
# Releases → Draft a new release
```

---

## ✅ Checklist de Vérification

### Avant Build
- [ ] Code freeze OK
- [ ] `flutter analyze` = 0 errors
- [ ] `flutter test` = tous passent
- [ ] Pas de TODOs urgents

### Après Build
- [ ] APK créé et testé
- [ ] AAB créé
- [ ] iOS build créé
- [ ] Taille raisonnable

### Avant Publication
- [ ] Version bumped
- [ ] CHANGELOG mis à jour
- [ ] Git committed et tagué
- [ ] APK signé

### Après Publication
- [ ] Google Play confirmé
- [ ] TestFlight confirmé
- [ ] GitHub Release créée
- [ ] Announcement postée

---

## 📝 Mise à Jour du CHANGELOG

```markdown
## [1.0.0-beta.1] - 2025-11-29

### ✨ Ajouté
- Système d'authentification complet
- Gestion de compte utilisateur
- Base de données Hive intégrée
- Documentation complète

### 🐛 Fixé
- Compilation errors
- Import issues
- UI bugs

### 📱 Platforms
- ✅ Android API 21+
- ✅ iOS 12.0+
```

---

## 📧 Annonce

```
🎉 LevelMind 1.0.0-beta.1 is Now Live! 

We're excited to announce the first beta release of LevelMind!

🔐 Features:
- Complete authentication system
- User account management
- Local data persistence with Hive
- Smooth UI/UX transitions

📥 Download:
- Android: Google Play Beta (link)
- iOS: TestFlight (link)
- Direct APK: GitHub Releases (link)

🐛 Report Issues:
https://github.com/josoavj/lvlmindapp/issues

🗓️ Next Release:
1.0.0-beta.2 → December 15, 2025

Thank you for testing LevelMind! Your feedback is valuable.

Made with ❤️ by the LevelMind Team
```

---

## 🆘 Dépannage

### Erreur: "version.json not found"
```bash
flutter clean
flutter pub get
flutter pub run build_runner build
```

### Erreur: "APK not found"
```bash
flutter build apk --release -v
# Vérifier les erreurs détaillées
```

### Erreur: "Keystore not found"
```bash
# Créer la keystore (voir étape 7)
keytool -genkey -v -keystore ~/.android/release-key.jks ...
```

### Git tag already exists
```bash
# Supprimer le tag local et distant
git tag -d v1.0.0-beta.1
git push origin :refs/tags/v1.0.0-beta.1

# Recréer
./release.sh tag 1.0.0-beta.1
```

---

## ⏭️ Après la Première Release

### Day 1 (Publication)
- [ ] Monitorer les premiers utilisateurs
- [ ] Vérifier les crash reports
- [ ] Lire les premiers reviews

### Week 1
- [ ] Recueillir le feedback
- [ ] Identifier les bugs critiques
- [ ] Planifier les fixes pour beta.2

### Week 2
- [ ] Implémenter les fixes
- [ ] Préparer beta.2
- [ ] Tester les changements

### Prêt pour Beta.2?
```bash
./release.sh version 1.0.0-beta.2
./release.sh build 1.0.0-beta.2
./release.sh tag 1.0.0-beta.2
# Et redéployer
```

---

## 📚 Ressources Complètes

- 📖 **RELEASE_GUIDE.md** - Guide détaillé complet
- 🏗️ **ARCHITECTURE_OVERVIEW.md** - Comprendre l'architecture
- 📋 **CHANGELOG.md** - Historique complet
- 🚀 **QUICK_START.md** - Démarrer rapidement
- 📄 **README.md** - Documentation générale

---

## 🎓 Commandes Rapides

```bash
# Vérifier l'environnement
flutter doctor
flutter analyze

# Tester rapidement
flutter test

# Run sur appareil
flutter run
flutter run -d ios

# Build sans release
flutter build apk
flutter build ios --no-codesign

# Nettoyer complètement
rm -rf build/ ios/Pods/ .dart_tool/
flutter clean
flutter pub get
```

---

## 💡 Tips & Tricks

✅ **Toujours committer avant de builder:**
```bash
git add -A
git commit -m "Ready for beta.1"
```

✅ **Sauvegarder la keystore:**
```bash
# Sauvegarde sécurisée
cp ~/.android/release-key.jks ~/Backups/
```

✅ **Vérifier la signature:**
```bash
jarsigner -verify -verbose build/app/outputs/flutter-app.apk
```

✅ **Monitorer les crashs:**
- Google Play Console → Vitals → Crashes
- Ou Firebase Crashlytics (futur)

---

## 📞 Support

**Besoin d'aide?**
- 📧 support@levelmind.app
- 💬 GitHub Issues: [Créer une issue](https://github.com/josoavj/lvlmindapp/issues)
- 🐙 GitHub Discussions
- 🆘 In-app help (futur)

---

**Bonne chance avec votre première release! 🚀**

---

*Last Updated: 2025-11-29*  
*Version: 1.0.0*  
*Author: @josoavj*
