import 'package:flutter/material.dart';

import '../screens/deconnexion.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Données fictives pour le profil (devraient être chargées dynamiquement)
  final String _userName = "Josoa Vonjiniaina"; // Nom de l'utilisateur
  final String _userStatus = "Étudiant"; // Statut (Étudiant ou Professeur)
  final String _userAvatarPath = 'assets/images/profil_placeholder.png'; // Chemin de l'image de l'avatar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(), // Utilisation d'une AppBar personnalisée
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        children: [
          // Section supérieure du profil (Avatar et Nom)
          Card(
            color: Colors.blueAccent, // Couleur de fond de la carte
            elevation: 8, // Élévation de la carte
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Coins arrondis pour la carte
            ),
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10), // Marge pour la carte
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40, // Taille de l'avatar
                    backgroundColor: Colors.white, // Fond blanc pour l'avatar
                    child: ClipOval( // Pour s'assurer que l'image est bien ronde
                      child: Image.asset(
                        _userAvatarPath,
                        fit: BoxFit.cover, // S'assure que l'image remplit le cercle
                        width: 80,
                        height: 80,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey, // Icône par défaut si l'image ne charge pas
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 20), // Espacement entre l'avatar et le texte
                  Expanded( // Permet au texte de prendre l'espace restant
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userName, // Nom de l'utilisateur
                          style: const TextStyle(
                            fontFamily: 'Josefin',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.white, // Texte en blanc pour contraster avec le fond bleu
                          ),
                          overflow: TextOverflow.ellipsis, // Gère le débordement si le nom est long
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _userStatus, // Statut de l'utilisateur
                          style: TextStyle(
                            fontFamily: 'Josefin',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.8), // Couleur légèrement transparente
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30), // Espacement entre les sections

          // Section "Cours les plus suivis"
          _buildSectionTitle("Mes Cours Préférés"),
          const SizedBox(height: 15),
          SizedBox(
            height: 150, // Hauteur fixe pour la liste de cours
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4, // Nombre de cours fictifs
              itemBuilder: (context, index) {
                // Widget pour chaque carte de cours (ex: image du cours, titre)
                return _buildCourseCard(
                  'assets/images/course_placeholder_${index + 1}.png', // Chemin fictif
                  'Cours de ${['Flutter', 'Python', 'Web Dev', 'IA'][index]}',
                  '${(index + 1) * 10}h de suivi', // Durée fictive
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          // Section "Statistiques d'activité hebdomadaire"
          _buildSectionTitle("Activité Hebdomadaire"),
          const SizedBox(height: 15),
          // Placeholder pour le graphique ou les statistiques
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bar_chart, size: 80, color: Colors.grey[600]),
                const SizedBox(height: 10),
                const Text(
                  "Graphique d'activité ici",
                  style: TextStyle(
                    fontFamily: 'Josefin',
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  "3h 45min étudiées cette semaine",
                  style: TextStyle(
                    fontFamily: 'Josefin',
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Autres informations (ex: Paramètres, Aide, Déconnexion)
          _buildOptionTile(Icons.settings, "Paramètres", () { /* Naviguer vers les paramètres */ }),
          _buildOptionTile(Icons.help_outline, "Aide et Support", () { /* Naviguer vers l'aide */ }),
          _buildOptionTile(Icons.logout, "Déconnexion", () {
    DeconnexionService.showLogoutConfirmation(context);
    }),
        ],
      ),
    );
  }

  // --- Widgets de construction pour la réutilisabilité ---

  // AppBar personnalisée pour la page de profil
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blueAccent, // Couleur de fond de l'AppBar
      elevation: 0, // Pas d'ombre sous l'AppBar
      centerTitle: true,
      title: const Text(
        "Mon Profil",
        style: TextStyle(
          fontFamily: 'Josefin',
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.white, // Texte en blanc
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white), // Icône de retour blanche
        onPressed: () {
          Navigator.of(context).pop(); // Revenir à la page précédente
        },
      ),
    );
  }

  // Titre de section réutilisable
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Josefin',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Color.fromARGB(166, 0, 0, 0),
      ),
    );
  }

  // Carte de cours pour la liste horizontale
  Widget _buildCourseCard(String imagePath, String title, String duration) {
    return Container(
      width: 140, // Largeur fixe pour chaque carte de cours
      margin: const EdgeInsets.only(right: 15), // Marge à droite pour l'espacement
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.school,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0), // Padding pour le titre du cours (tous les côtés)
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Josefin',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Correction ici : Utilisation de EdgeInsets.only pour le padding inférieur
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: Text(
                duration,
                style: const TextStyle(
                  fontFamily: 'Josefin',
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tuile d'option réutilisable (pour Paramètres, Aide, Déconnexion)
  Widget _buildOptionTile(IconData icon, String title, VoidCallback onTap) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Josefin',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(166, 0, 0, 0),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }