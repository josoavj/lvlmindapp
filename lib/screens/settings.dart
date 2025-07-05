import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lvlmindbeta/providers/theme_notifier.dart'; // Assurez-vous que ce chemin est correct

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'Français';

  @override
  Widget build(BuildContext context) {
    // Écoutez le ThemeNotifier pour obtenir l'état actuel du thème.
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final bool isDarkMode = themeNotifier.themeMode == ThemeMode.dark;
    final String currentThemeName = isDarkMode ? 'Sombre' : 'Clair';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Paramètres",
          style: TextStyle(
            fontFamily: 'Josefin',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        // Les couleurs de l'AppBar sont gérées par le thème de MaterialApp
        // backgroundColor: Colors.blueAccent, // N'est plus nécessaire ici
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Couleur gérée par le thème
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- Section Général ---
          _buildSectionTitle("Général"),
          SwitchListTile(
            title: const Text(
              "Activer les notifications",
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
              // Logique pour gérer les notifications
            },
            secondary: const Icon(Icons.notifications), // Couleur gérée par le thème
            activeColor: Colors.blueAccent,
          ),
          SwitchListTile(
            title: const Text(
              "Mode Sombre",
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            value: isDarkMode, // Lire l'état du thème directement depuis ThemeNotifier
            onChanged: (bool value) {
              themeNotifier.toggleTheme(); // Appeler la méthode toggleTheme du ThemeNotifier
            },
            secondary: const Icon(Icons.dark_mode), // Couleur gérée par le thème
            activeColor: Colors.blueAccent,
          ),
          ListTile(
            title: const Text(
              "Langue",
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            subtitle: Text(_selectedLanguage),
            leading: const Icon(Icons.language), // Couleur gérée par le thème
            trailing: const Icon(Icons.arrow_forward_ios, size: 18), // Couleur gérée par le thème
            onTap: () {
              _showLanguagePicker(context);
            },
          ),
          ListTile(
            title: const Text(
              "Thème de l'application",
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            subtitle: Text(currentThemeName), // Afficher le nom du thème actuel
            leading: const Icon(Icons.palette), // Couleur gérée par le thème
            trailing: const Icon(Icons.arrow_forward_ios, size: 18), // Couleur gérée par le thème
            onTap: () {
              _showThemePicker(context, themeNotifier);
            },
          ),
          const Divider(),

          // --- Section Compte ---
          _buildSectionTitle("Compte"),
          ListTile(
            title: const Text(
              "Modifier le profil",
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            leading: const Icon(Icons.person),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              // Naviguer vers la page d'édition de profil
            },
          ),
          ListTile(
            title: const Text(
              "Changer le mot de passe",
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            leading: const Icon(Icons.lock),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              // Naviguer vers la page de changement de mot de passe
            },
          ),
          const Divider(),

          // --- Section Confidentialité et Sécurité ---
          _buildSectionTitle("Confidentialité et Sécurité"),
          ListTile(
            title: const Text(
              "Politique de confidentialité",
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            leading: const Icon(Icons.privacy_tip),
            trailing: const Icon(Icons.open_in_new, size: 18),
            onTap: () {
              // Ouvrir la politique de confidentialité dans un navigateur ou une WebView
            },
          ),
          ListTile(
            title: const Text(
              "Conditions d'utilisation",
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            leading: const Icon(Icons.description),
            trailing: const Icon(Icons.open_in_new, size: 18),
            onTap: () {
              // Ouvrir les conditions d'utilisation
            },
          ),
          SwitchListTile(
            title: const Text(
              "Authentification à deux facteurs",
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            value: false, // Exemple, devrait être une variable d'état
            onChanged: (bool value) {
              // Logique pour activer/désactiver la 2FA
            },
            secondary: const Icon(Icons.security),
            activeColor: Colors.blueAccent,
          ),
          const Divider(),

          // --- Section À propos ---
          _buildSectionTitle("À propos"),
          ListTile(
            title: const Text(
              "Version de l'application",
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            subtitle: const Text("1.0.0"), // Remplacer par la version réelle de l'app
            leading: const Icon(Icons.info_outline),
          ),
          ListTile(
            title: const Text(
              "Envoyer des retours",
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            leading: const Icon(Icons.feedback),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              // Ouvrir un formulaire de feedback ou un client de messagerie
            },
          ),
          ListTile(
            title: const Text(
              "Évaluer l'application",
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            leading: const Icon(Icons.star),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              // Rediriger vers la page de l'application sur le store
            },
          ),
        ],
      ),
    );
  }

  // --- Widgets et méthodes auxiliaires ---

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Text(
        title,
        style: TextStyle( // Utilise TextStyle pour s'adapter au thème (couleur texte)
          fontFamily: 'Josefin',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.titleLarge?.color, // S'adapte à la couleur de texte du thème
        ),
      ),
    );
  }

  // Affiche un sélecteur de langue
  void _showLanguagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                title: const Text('Français', style: TextStyle(fontFamily: 'Josefin')),
                trailing: _selectedLanguage == 'Français' ? const Icon(Icons.check, color: Colors.blueAccent) : null,
                onTap: () {
                  setState(() {
                    _selectedLanguage = 'Français';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('English', style: TextStyle(fontFamily: 'Josefin')),
                trailing: _selectedLanguage == 'English' ? const Icon(Icons.check, color: Colors.blueAccent) : null,
                onTap: () {
                  setState(() {
                    _selectedLanguage = 'English';
                  });
                  Navigator.pop(context);
                },
              ),
              // Ajoutez d'autres langues ici
            ],
          ),
        );
      },
    );
  }

  // Affiche un sélecteur de thème (maintenant avec themeNotifier)
  void _showThemePicker(BuildContext context, ThemeNotifier themeNotifier) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                title: const Text('Clair', style: TextStyle(fontFamily: 'Josefin')),
                trailing: themeNotifier.themeMode == ThemeMode.light ? const Icon(Icons.check, color: Colors.blueAccent) : null,
                onTap: () {
                  themeNotifier.setThemeMode(ThemeMode.light); // Définit le thème via notifier
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Sombre', style: TextStyle(fontFamily: 'Josefin')),
                trailing: themeNotifier.themeMode == ThemeMode.dark ? const Icon(Icons.check, color: Colors.blueAccent) : null,
                onTap: () {
                  themeNotifier.setThemeMode(ThemeMode.dark); // Définit le thème via notifier
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}