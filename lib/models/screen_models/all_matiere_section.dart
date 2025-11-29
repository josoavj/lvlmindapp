import 'package:flutter/material.dart';
import 'package:lvlmindbeta/models/matiere.dart';

import 'matiere_details.dart';

class AllMatieresPage extends StatelessWidget {
  const AllMatieresPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Récupérer toutes les matières
    final List<Matiere> allMatieres = Matiere.getFictionalCourses();

    // 2. Grouper les matières par leur filterTag (section)
    final Map<String, List<Matiere>> groupedMatieres = {};
    for (var matiere in allMatieres) {
      // Utilisez le filterTag de la matière comme clé de groupe.
      // Si le filterTag est vide ou nul, vous pouvez utiliser une catégorie par défaut comme 'Autre'.
      final String tag =
          matiere.filterTag.isNotEmpty ? matiere.filterTag : 'Autre';

      if (!groupedMatieres.containsKey(tag)) {
        groupedMatieres[tag] = [];
      }
      groupedMatieres[tag]!.add(matiere);
    }

    // 3. Trier les noms des sections par ordre alphabétique pour un affichage cohérent
    final List<String> sortedTags = groupedMatieres.keys.toList()..sort();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Toutes les Matières',
          style: TextStyle(
            fontFamily: 'Josefin',
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: sortedTags.length,
        itemBuilder: (context, sectionIndex) {
          final String tag = sortedTags[sectionIndex];
          final List<Matiere> matieresInSection = groupedMatieres[tag]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Afficher le nom de la section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  tag,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontFamily: 'Josefin',
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              // Afficher la liste des matières pour cette section
              Column(
                // Utilisation d'une Column pour éviter les problèmes de scroll avec des ListView imbriquées
                children: matieresInSection.map((matiere) {
                  return Card(
                    color: Theme.of(context).cardColor,
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      leading: SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset(
                          matiere.image,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.book,
                              color: Theme.of(context).iconTheme.color,
                              size: 30,
                            );
                          },
                        ),
                      ),
                      title: Text(
                        matiere.name,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontFamily: 'Josefin',
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      trailing: Text(
                        matiere.chapterCount
                            .toString(), // Convertir l'int en String
                        style: const TextStyle(
                          fontFamily: 'Josefin',
                          fontSize: 13,
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        // Naviguer vers la page de détails de la matière
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MatiereDetailsPage(matiere: matiere)),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                  height: 16.0), // Espacement entre les différentes sections
            ],
          );
        },
      ),
    );
  }
}
