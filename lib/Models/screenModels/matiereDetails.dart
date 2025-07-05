import 'package:flutter/material.dart';

import '../matiere.dart';

class MatiereDetailsPage extends StatelessWidget {
  final Matiere matiere; // Le professeur passé en paramètre

  const MatiereDetailsPage({super.key, required this.matiere});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          matiere.name, // Titre de l'AppBar est le nom de la matière
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image de la matière
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  matiere.image,
                  fit: BoxFit.cover,
                  height: 180,
                  width: 180,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.menu_book,
                      size: 150,
                      color: Theme.of(context).iconTheme.color?.withOpacity(0.6),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 25),

            // Nom de la matière (peut-être déjà dans l'appbar, mais ici pour plus de détails si besoin)
            Text(
              matiere.name,
              style: TextStyle(
                fontFamily: 'Josefin',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Nombre de chapitres
            Text(
              "Total : ${matiere.number}",
              style: TextStyle(
                fontFamily: 'Josefin',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.green, // Ou une couleur de votre thème
              ),
            ),
            const SizedBox(height: 25),

            // Titre des chapitres
            Text(
              "Chapitres :",
              style: TextStyle(
                fontFamily: 'Josefin',
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
            const SizedBox(height: 15),

            // Liste des chapitres
            // Utilisez ListView.builder dans un Expanded ou SizedBox pour éviter les erreurs de render
            // si la liste est longue. Ou simplement Column si le nombre de chapitres est fixe et petit.
            // Pour 10 chapitres, Column est acceptable.
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: matiere.chapters.map((chapter) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle_outline, size: 20, color: Colors.blueAccent),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          chapter,
                          style: TextStyle(
                            fontFamily: 'Josefin',
                            fontSize: 16,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}