import 'package:flutter/material.dart';

import '../matiere.dart';
import 'matiereDetails.dart';

class MatieresListPage extends StatelessWidget {
  const MatieresListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Récupère la liste complète des matières
    List<Matiere> allMatieres = Matiere.getFictionalCourses().toList(); // .toList() pour la rendre modifiable si besoin

    // Trie les matières par ordre alphabétique de leur nom
    allMatieres.sort((a, b) => a.name.compareTo(b.name));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Toutes nos Matières",
          style: TextStyle(
            fontFamily: 'Josefin',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: Theme.of(context).appBarTheme.elevation,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).appBarTheme.foregroundColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: allMatieres.length,
          itemBuilder: (context, index) {
            final matiere = allMatieres[index];
            return Card(
              color: Theme.of(context).cardColor,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                onTap: () {
                  // Navigue vers la MatiereDetailsPage en passant l'objet matiere
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MatiereDetailsPage(matiere: matiere),
                    ),
                  );
                },
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    matiere.image,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.book_outlined, // Icône de secours
                        color: Theme.of(context).iconTheme.color,
                        size: 40,
                      );
                    },
                  ),
                ),
                title: Text(
                  matiere.name,
                  style: TextStyle(
                    fontFamily: 'Josefin',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
                subtitle: Text(
                  matiere.chapterCount as String, // Affiche "10 Chapitres"
                  style: TextStyle(
                    fontFamily: 'Josefin',
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).iconTheme.color?.withOpacity(0.7),
                  size: 18,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}