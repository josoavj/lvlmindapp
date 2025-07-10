import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lvlmindbeta/providers/theme_notifier.dart';
import 'package:url_launcher/url_launcher.dart';

import 'aboutDevelopers.dart';
import 'editProfilePage.dart';

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
        title: Text(
          "Paramètres",
          style: TextStyle(
            fontFamily: 'Josefin',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            // Utilise la couleur du texte de l'AppBar du thème, ou blanc par défaut
            color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.white,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).appBarTheme.foregroundColor, // Couleur de l'icône de l'AppBar du thème
          ),
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
              // Ex: Appeler une API ou un service de notification
              _showSnackBar(context, "Notifications ${value ? 'activées' : 'désactivées'}");
            },
            secondary: Icon(
              Icons.notifications,
              color: Theme.of(context).iconTheme.color, // Couleur de l'icône du thème
            ),
            activeColor: Theme.of(context).colorScheme.primary, // Couleur principale du thème
          ),
          SwitchListTile(
            title: const Text(
              "Mode Sombre",
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            value: isDarkMode,
            onChanged: (bool value) {
              themeNotifier.toggleTheme();
            },
            secondary: Icon(
              Icons.dark_mode,
              color: Theme.of(context).iconTheme.color,
            ),
            activeColor: Theme.of(context).colorScheme.primary,
          ),
          ListTile(
            title: const Text(
              "Langue",
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            subtitle: Text(_selectedLanguage),
            leading: Icon(
              Icons.language,
              color: Theme.of(context).iconTheme.color,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {
              _showLanguagePicker(context);
            },
          ),
          ListTile(
            title: const Text(
              "Thème de l'application",
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            subtitle: Text(currentThemeName),
            leading: Icon(
              Icons.palette,
              color: Theme.of(context).iconTheme.color,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Theme.of(context).iconTheme.color,
            ),
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
            leading: Icon(Icons.person, color: Theme.of(context).iconTheme.color),
            trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Theme.of(context).iconTheme.color),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfilePage()),
              );
            },
          ),
          ListTile(
            title: const Text(
              "Changer le mot de passe",
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            leading: Icon(Icons.lock, color: Theme.of(context).iconTheme.color),
            trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Theme.of(context).iconTheme.color),
            onTap: () {
              _showSnackBar(context, "Fonctionnalité 'Changer le mot de passe' à implémenter");
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
            leading: Icon(Icons.privacy_tip, color: Theme.of(context).iconTheme.color),
            trailing: Icon(Icons.open_in_new, size: 18, color: Theme.of(context).iconTheme.color),
            onTap: () {
              _launchURL('https://www.example.com/privacy'); // Remplacez par votre lien réel
            },
          ),
          ListTile(
            title: const Text(
              "Conditions d'utilisation",
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            leading: Icon(Icons.description, color: Theme.of(context).iconTheme.color),
            trailing: Icon(Icons.open_in_new, size: 18, color: Theme.of(context).iconTheme.color),
            onTap: () {
              _launchURL('https://www.example.com/terms'); // Remplacez par votre lien réel
            },
          ),
          SwitchListTile(
            title: const Text(
              "Authentification à deux facteurs",
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            value: false, // Exemple, devrait être une variable d'état liée à la logique réelle
            onChanged: (bool value) {
              // Logique pour activer/désactiver la 2FA
              _showSnackBar(context, "Authentification à deux facteurs ${value ? 'activée' : 'désactivée'}");
            },
            secondary: Icon(Icons.security, color: Theme.of(context).iconTheme.color),
            activeColor: Theme.of(context).colorScheme.primary,
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
            leading: Icon(Icons.info_outline, color: Theme.of(context).iconTheme.color),
          ),
          ListTile(
            title: const Text(
              "Développeurs", // Nouvelle entrée
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            leading: Icon(Icons.code, color: Theme.of(context).iconTheme.color),
            trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Theme.of(context).iconTheme.color),
            onTap: () {
              // Navigue vers la nouvelle page des informations sur les développeurs
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutDevelopersPage()),
              );
            },
          ),
          ListTile(
            title: const Text(
              "Envoyer des retours",
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            leading: Icon(Icons.feedback, color: Theme.of(context).iconTheme.color),
            trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Theme.of(context).iconTheme.color),
            onTap: () {
              _launchURL('mailto:feedback@lvlmind.com?subject=Retour%20sur%20l\'application'); // Remplacez par votre adresse e-mail
            },
          ),
          ListTile(
            title: const Text(
              "Évaluer l'application",
              style: TextStyle(fontFamily: 'Josefin', fontSize: 16),
            ),
            leading: Icon(Icons.star, color: Theme.of(context).iconTheme.color),
            trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Theme.of(context).iconTheme.color),
            onTap: () {
              // Rediriger vers la page de l'application sur le store (exemple Android)
              _launchURL('market://details?id=com.lvlmind.beta'); // Remplacez par votre ID de package
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
        style: TextStyle(
          fontFamily: 'Josefin',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.titleLarge?.color,
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
                trailing: _selectedLanguage == 'Français' ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                onTap: () {
                  setState(() {
                    _selectedLanguage = 'Français';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('English', style: TextStyle(fontFamily: 'Josefin')),
                trailing: _selectedLanguage == 'English' ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
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
                trailing: themeNotifier.themeMode == ThemeMode.light ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                onTap: () {
                  themeNotifier.setThemeMode(ThemeMode.light);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Sombre', style: TextStyle(fontFamily: 'Josefin')),
                trailing: themeNotifier.themeMode == ThemeMode.dark ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                onTap: () {
                  themeNotifier.setThemeMode(ThemeMode.dark);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Fonction pour lancer des URLs
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      if (mounted) {
        _showSnackBar(context, 'Impossible d\'ouvrir le lien : $url');
      }
    }
  }

  // Petite fonction utilitaire pour afficher des SnackBar
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}