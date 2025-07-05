import 'package:flutter/material.dart';
import 'package:lvlmindbeta/screens/welcomepage.dart';
import 'package:lvlmindbeta/Models/profs.dart';
import 'package:lvlmindbeta/screens/profsDetails.dart';

class FilesPage extends StatefulWidget {
  const FilesPage({super.key});

  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  // Liste des professeurs provenant du modèle
  final List<Profs> teachers = profList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nos Professeurs",
          style: TextStyle(
            fontFamily: 'Josefin',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // S'adapte au thème
        elevation: Theme.of(context).appBarTheme.elevation, // S'adapte au thème
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).appBarTheme.foregroundColor), // Couleur gérée par le thème
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => const WelcomePage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 colonnes par défaut
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75, // Ajustez si nécessaire pour que les cartes aient une bonne taille
          ),
          itemCount: teachers.length,
          itemBuilder: (context, index) {
            final prof = teachers[index];
            return _buildProfCard(context, prof); // Utilise la fonction de construction de carte
          },
        ),
      ),
    );
  }

  // Fonction pour construire une carte de professeur cliquable
  Widget _buildProfCard(BuildContext context, Profs prof) {
    return Card(
      color: Theme.of(context).cardColor, // S'adapte au thème
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell( // Rendre la carte cliquable
        onTap: () {
          // Navigue vers la ProfDetailsPage en passant l'objet prof
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfDetailsPage(prof: prof),
            ),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  prof.profpic,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      prof.profname,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge?.color, // S'adapte au thème
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      prof.profeducation,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodyMedium?.color, // S'adapte au thème
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}