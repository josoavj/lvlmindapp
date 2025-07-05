import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/profs.dart';

class ProfDetailsPage extends StatelessWidget {
  final Profs prof;

  const ProfDetailsPage({super.key, required this.prof});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Permet au contenu de s'étendre derrière l'AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBar transparente
        elevation: 0,
        title: Text(
          prof.profname,
          style: const TextStyle(
            fontFamily: 'Josefin',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Texte blanc pour contraster avec le fond sombre ou l'image
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30), // Bouton retour blanc
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context), // En-tête avec image de profil et nom
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildSectionTitle("Informations Générales"),
                  _buildInfoRow(Icons.school, "Éducation", prof.profeducation),
                  const SizedBox(height: 10),
                  _buildInfoRow(Icons.description, "Biographie", prof.bio),
                  const SizedBox(height: 20),

                  _buildSectionTitle("Contact"),
                  _buildContactRow(Icons.phone, prof.phone, () => _launchPhone(prof.phone)),
                  const SizedBox(height: 10),
                  _buildContactRow(Icons.email, prof.email, () => _launchEmail(prof.email)),
                  const SizedBox(height: 20),

                  _buildSectionTitle("Cours Enseignés"),
                  _buildCoursesList(prof.courses),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // En-tête avec l'image du prof et son nom/éducation
  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 250, // Hauteur fixe pour l'image d'en-tête
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(prof.profpic),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4), // Assombrir l'image pour la lisibilité du texte
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prof.profname,
                  style: const TextStyle(
                    fontFamily: 'Josefin',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  prof.profeducation,
                  style: const TextStyle(
                    fontFamily: 'Josefin',
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Titre de section (e.g., "Informations Générales")
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Josefin',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.titleLarge?.color, // S'adapte au thème
        ),
      ),
    );
  }

  // Ligne d'information (icône, titre, contenu)
  Widget _buildInfoRow(IconData icon, String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24, color: Theme.of(context).iconTheme.color), // S'adapte au thème
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Josefin',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              Text(
                content,
                style: TextStyle(
                  fontFamily: 'Josefin',
                  fontSize: 15,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Ligne de contact cliquable (téléphone, email)
  Widget _buildContactRow(IconData icon, String text, VoidCallback onTap) {
    return InkWell( // Rend la ligne cliquable
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Theme.of(context).iconTheme.color),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Josefin',
                fontSize: 16,
                color: Theme.of(context).textButtonTheme.style?.foregroundColor?.resolve({MaterialState.selected}), // Utilise la couleur des TextButton
                decoration: TextDecoration.underline, // Souligne le texte pour indiquer que c'est un lien
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Liste des cours enseignés
  Widget _buildCoursesList(List<String> courses) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: courses
          .map(
            (course) => Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.check_circle_outline, size: 20, color: Colors.green[700]),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  course,
                  style: TextStyle(
                    fontFamily: 'Josefin',
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          .toList(),
    );
  }

  // Fonction pour lancer un appel téléphonique
  Future<void> _launchPhone(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible de lancer l\'appel.')),
      );
    }
  }

  // Fonction pour lancer un email
  Future<void> _launchEmail(String emailAddress) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible d\'ouvrir l\'application email.')),
      );
    }
  }
}