import 'package:flutter/material.dart';
import '../Models/profs.dart';
import '../screens/profsDetails.dart';

class FilesPage extends StatefulWidget {
  const FilesPage({super.key});

  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  // Liste des professeurs provenant du modèle
  final List<Profs> teachers = Profs.getFictionalProfs(); // Utilise la méthode statique

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( // Le widget Text peut changer de couleur via le thème
          "Nos Professeurs",
          style: TextStyle( // Le TextStyle doit être explicite ici car la couleur du titre d'AppBar est souvent fixée
            fontFamily: 'Josefin',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).appBarTheme.foregroundColor, // S'adapte à la couleur du texte/icônes de l'AppBar
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // S'adapte au thème
        elevation: Theme.of(context).appBarTheme.elevation, // S'adapte au thème
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).appBarTheme.foregroundColor), // Couleur gérée par le thème
          onPressed: () {
            // Note: Si WelcomePage est la racine de votre Navigator, Navigator.pop() suffira.
            // Si vous naviguez spécifiquement vers WelcomePage, le code ci-dessous est correct.
            Navigator.pop(context); // Un simple pop est souvent suffisant pour revenir en arrière.
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
      color: Theme.of(context).cardColor, // S'adapte au thème (cardColor défini dans main.dart)
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
                  prof.iconpath, // Utilise iconpath
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.person,
                    size: 80,
                    color: Theme.of(context).iconTheme.color, // S'adapte au thème
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
                      prof.pname, // Utilise pname
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
                      prof.profeducation, // Utilise profeducation
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