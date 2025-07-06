// File: lib/screens/about_developers_page.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // N'oubliez pas l'importation

class AboutDevelopersPage extends StatelessWidget {
  const AboutDevelopersPage({super.key});

  // Fonction utilitaire pour lancer des URLs
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      // Pour une meilleure gestion d'erreur, vous pourriez afficher un SnackBar
      // ou une boîte de dialogue si le lien ne peut pas être ouvert.
      debugPrint('Impossible de lancer $url'); // Affichage dans la console de debug
      //throw 'Impossible de lancer $url'; // Vous pouvez choisir de relancer une erreur si nécessaire
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "À propos des développeurs",
          style: TextStyle(
            fontFamily: 'Josefin',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.white,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "L'application LevelMind a été développée avec passion et dévouement par :",
              style: TextStyle(
                fontFamily: 'Josefin',
                fontSize: 16,
                height: 1.5,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            const SizedBox(height: 20),

            _buildDeveloperInfo(
              context,
              name: "Josoa Vonjiniaina",
              role: "Développeur Principal (Et UI,UX)",
              githubUsername: "josoavj",
              githubProfileUrl: "https://github.com/josoavj",
            ),

            const SizedBox(height: 20,),

            _buildDeveloperInfo(
              context,
              name: "Faly Fiatoa",
              role: "Développeur Principal",
              githubUsername: "foulburst",
              githubProfileUrl: "https://github.com/foulburst",
            ),

            const SizedBox(height: 30),

            // Informations sur le dépôt du projet
            Text(
              "Dépôt GitHub du Projet :",
              style: TextStyle(
                fontFamily: 'Josefin',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.code, color: Theme.of(context).iconTheme.color),
              title: Text(
                "lvlmindapp (Dépôt Principal)",
                style: TextStyle(
                  fontFamily: 'Josefin',
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              trailing: Icon(Icons.open_in_new, size: 18, color: Theme.of(context).iconTheme.color),
              onTap: () => _launchURL("https://github.com/josoavj/lvlmindapp"),
            ),
            const SizedBox(height: 30),

            Text(
              "Nous sommes ravis de partager notre travail avec vous et apprécions vos retours !",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Josefin',
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliaire pour afficher les informations d'un développeur
  Widget _buildDeveloperInfo(
      BuildContext context, {
        required String name,
        required String role,
        required String githubUsername, // Gardez ce paramètre
        required String githubProfileUrl,
      }) {
    // Construction de l'URL de l'image de profil GitHub
    final String githubAvatarUrl = 'https://github.com/$githubUsername.png?size=200'; // Taille 200px

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest ?? Colors.grey.shade300,
              child: ClipOval(
                child: Image.network(
                  githubAvatarUrl,
                  fit: BoxFit.cover,
                  width: 60, // Doit correspondre à 2 * radius (2 * 30)
                  height: 60, // Doit correspondre à 2 * radius
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint('Erreur de chargement de l\'image pour $name ($githubAvatarUrl): $error');
                    return Icon(
                      Icons.person,
                      size: 40,
                      color: Theme.of(context).colorScheme.onSurface,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Josefin',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
                Text(
                  role,
                  style: TextStyle(
                    fontFamily: 'Josefin',
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.link, color: Theme.of(context).iconTheme.color),
          title: Text(
            "Profil GitHub : $githubUsername",
            style: TextStyle(
              fontFamily: 'Josefin',
              fontSize: 15,
              color: Theme.of(context).colorScheme.primary,
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: () => _launchURL(githubProfileUrl),
        ),
      ],
    );
  }
}