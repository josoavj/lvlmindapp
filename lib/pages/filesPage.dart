import 'package:flutter/material.dart';
import 'package:lvlmindbeta/Models/screenModels/profInfo.dart';
import 'package:lvlmindbeta/Models/profs.dart';
import 'package:lvlmindbeta/Models/matiere.dart';
import '../screens/profsDetails.dart';

class Files extends StatefulWidget {
  const Files({super.key});

  @override
  _FilesState createState() => _FilesState();
}

class _FilesState extends State<Files> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<Matiere> _matieres = [];
  List<Profs> _professeurs = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _matieres = Matiere.getFictionalCourses();
      _professeurs = Profs.getFictionalProfs();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: _buildAppBar(context), // Utilisation de la barre d'application refactorisée
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        children: [
          // Image de bienvenue centrée
          Center(
            child: SizedBox(
              width: 650,
              child: Image.asset(
                'assets/images/icons/welcome.jpg',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                  size: 100,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Professeurs",
                style: TextStyle(
                  fontFamily: 'Josefin',
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).textTheme.titleLarge?.color, // Adapte la couleur au thème
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigue vers la ProfsListPage (la page "Voir tout")
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfProfile()),
                  );
                },
                child: Text(
                  "Voir tout",
                  style: TextStyle(
                    fontFamily: 'Josefin',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).textButtonTheme.style?.foregroundColor?.resolve({MaterialState.selected}), // Adapte la couleur au thème
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Liste horizontale des professeurs
          SizedBox(
            height: 220, // Hauteur ajustée pour une meilleure visibilité des cartes
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              itemCount: _professeurs.length,
              separatorBuilder: (context, index) => const SizedBox(width: 20),
              itemBuilder: (context, index) {
                final prof = _professeurs[index];
                return GestureDetector(
                  onTap: () {
                    // Navigue vers la ProfDetailsPage en passant l'objet professeur
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfDetailsPage(prof: prof)),
                    );
                  },
                  child: Card(
                    color: Theme.of(context).cardColor, // Adapte la couleur de la carte au thème
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Coins arrondis
                    child: SizedBox(
                      width: 150, // Largeur fixe pour chaque petite carte
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.asset(
                              prof.iconpath, // Utilise iconpath
                              fit: BoxFit.cover,
                              height: 120, // Hauteur de l'image
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.person_pin,
                                  color: Theme.of(context).iconTheme.color, // Adapte la couleur au thème
                                  size: 70,
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  prof.pname, // Utilise pname
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Josefin',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).textTheme.titleLarge?.color, // Adapte la couleur au thème
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  prof.profeducation.split(',').first, // Affiche juste la première partie de l'éducation
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Josefin',
                                    fontSize: 12,
                                    color: Theme.of(context).textTheme.bodyMedium?.color, // Adapte la couleur au thème
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          // --- FIN DE LA SECTION "PROFESSEURS" MISE À JOUR ---

          // Section "Matières" (inchangée, mais assurez-vous des couleurs adaptatives)
          Text(
            "Matières",
            style: TextStyle(
              fontFamily: 'Josefin',
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.titleLarge?.color, // Adapte la couleur au thème
            ),
          ),
          const SizedBox(height: 15),

          SizedBox(
            height: 450,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              itemCount: _matieres.length,
              itemBuilder: (context, index) {
                final matiere = _matieres[index];
                return Card(
                  color: Theme.of(context).cardColor, // Adapte la couleur de la carte au thème
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/coursesContent');
                    },
                    leading: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset(
                        matiere.image,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.book,
                            color: Theme.of(context).iconTheme.color, // Adapte la couleur au thème
                            size: 30,
                          );
                        },
                      ),
                    ),
                    title: Text(
                      matiere.name,
                      style: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).textTheme.bodyLarge?.color, // Adapte la couleur au thème
                      ),
                    ),
                    trailing: Text(
                      matiere.number,
                      style: const TextStyle( // Note: Les couleurs fixes peuvent ne pas s'adapter au thème
                        fontFamily: 'Josefin',
                        fontSize: 13,
                        color: Colors.greenAccent, // Conserve votre couleur originale
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Barre d'application personnalisée pour la page des fichiers.
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Adapte la couleur au thème
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        'Matériel de cours',
        style: TextStyle(
          fontFamily: 'Josefin',
          fontSize: 22,
          color: Theme.of(context).appBarTheme.foregroundColor, // Adapte la couleur au thème
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}