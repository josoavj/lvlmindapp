// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lvlmindbeta/Models/screenModels/profInfo.dart'; // Assurez-vous que ce chemin est correct
import 'package:lvlmindbeta/Models/profs.dart'; // Assurez-vous que ce chemin est correct et que la classe Profs est à jour
import 'package:lvlmindbeta/Models/matiere.dart'; // Assurez-vous que ce chemin est correct et que la classe Matiere est à jour

class Files extends StatefulWidget {
  const Files({super.key});

  @override
  _FilesState createState() => _FilesState();
}

class _FilesState extends State<Files> with AutomaticKeepAliveClientMixin {
  // Garde l'état du widget vivant lorsque vous naviguez loin et revenez
  @override
  bool get wantKeepAlive => true;

  // Listes pour stocker les données des matières et des professeurs
  List<Matiere> _matieres = [];
  List<Profs> _professeurs = [];

  @override
  void initState() {
    super.initState();
    // Initialise les données au démarrage de la page
    _loadData();
  }

  // Méthode pour charger les données des matières et des professeurs
  void _loadData() {
    setState(() {
      _matieres = Matiere.getFictionalCourses(); // Utilisation de la nouvelle fonction getFictionalCourses
      _professeurs = Profs.getFictionalProfs(); // Assurez-vous que Profs a aussi une fonction getFictionalProfs()
    });
  }

  @override
  Widget build(BuildContext context) {
    // Appelle super.build(context) pour le mixin AutomaticKeepAliveClientMixin
    super.build(context);

    // Ne PAS appeler _loadData() ici, cela provoquerait des appels setState() infinis.
    // Les données sont chargées une seule fois dans initState.

    return Scaffold(
      appBar: _buildAppBar(context), // Utilisation de la barre d'application refactorisée
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        children: [
          // Image de bienvenue centrée
          Center(
            child: SizedBox(
              width: 650, // Peut être ajusté selon la taille de l'image réelle
              child: Image.asset(
                'assets/images/icons/welcome.jpg',
                fit: BoxFit.contain, // Ajuste l'image pour qu'elle tienne dans la boîte
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                  size: 100,
                ), // Icône si l'image ne charge pas
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Section "Professeurs"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Professeurs", // Traduit de "Teacher"
                style: TextStyle(
                  fontFamily: 'Josefin',
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(166, 0, 0, 0),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/profListedProfile');
                },
                child: const Text(
                  "Voir tout", // Traduit de "See all"
                  style: TextStyle(
                    fontFamily: 'Josefin',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(223, 222, 75, 161),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15), // Espace après le titre "Professeurs"

          // Liste horizontale des professeurs
          SizedBox(
            height: 110, // Hauteur fixe pour la ListView horizontale
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              itemCount: _professeurs.length,
              separatorBuilder: (context, index) => const SizedBox(width: 20),
              itemBuilder: (context, index) {
                final prof = _professeurs[index];
                return GestureDetector(
                  onTap: () {
                    // Passe l'objet professeur si ProfProfile en a besoin
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfProfile()),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    child: SizedBox( // Utilisation de SizedBox pour contraindre la taille de la carte
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image du professeur
                          SizedBox(
                            width: 50,
                            height: 40,
                            child: Image.asset(
                              prof.iconpath, // Chemin de l'image du professeur
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.person_pin, // Icône par défaut pour les profs
                                  color: Colors.grey,
                                  size: 30,
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10), // Espacement réduit
                          // Nom du professeur
                          Text(
                            prof.pname,
                            textAlign: TextAlign.center, // Centrer le nom
                            style: const TextStyle(
                              fontFamily: 'Josefin',
                              fontSize: 14, // Taille de police légèrement ajustée
                              fontWeight: FontWeight.w400, // Poids de police ajusté
                              color: Color.fromARGB(255, 65, 64, 64),
                            ),
                            maxLines: 2, // Limite à 2 lignes pour les noms longs
                            overflow: TextOverflow.ellipsis, // Gère le débordement
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

          // Section "Matières"
          const Text(
            "Matières", // Traduit de "Courses"
            style: TextStyle(
              fontFamily: 'Josefin',
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(168, 0, 0, 0),
            ),
          ),
          const SizedBox(height: 15), // Espace après le titre "Matières"

          // Liste verticale des matières
          // Utilisation de Expanded ou d'une hauteur fixe si ce ListView est imbriqué
          // dans un Column sans contraintes de hauteur suffisantes.
          // Ici, je suppose qu'il est le dernier élément d'un ListView principal,
          // donc une hauteur fixe est une approche courante.
          SizedBox(
            height: 450, // Hauteur fixe pour la ListView des matières
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0), // Padding ajusté
              itemCount: _matieres.length,
              itemBuilder: (context, index) {
                final matiere = _matieres[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8), // Marge verticale entre les cartes
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/coursesContent');
                    },
                    leading: SizedBox(
                      width: 40, // Largeur fixe pour l'icône de la matière
                      height: 40,
                      child: Image.asset(
                        matiere.image, // Chemin de l'image de la matière
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.book, // Icône par défaut pour les matières
                            color: Colors.blueGrey,
                            size: 30,
                          );
                        },
                      ),
                    ),
                    title: Text(
                      matiere.name,
                      style: const TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 17,
                        fontWeight: FontWeight.w400, // Poids de police ajusté
                        color: Color.fromARGB(255, 65, 64, 64),
                      ),
                    ),
                    trailing: Text(
                      matiere.number,
                      style: const TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 13,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.w600, // Rendu plus lisible
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
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false, // Pas de bouton retour automatique
      centerTitle: true,
      title: const Text(
        'Matériel de cours', // Traduit de "Course materials"
        style: TextStyle(
          fontFamily: 'Josefin',
          fontSize: 22, // Taille de police légèrement augmentée
          color: Colors.blue,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}