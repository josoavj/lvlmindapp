import 'package:flutter/material.dart';
import '../../screens/profsDetails.dart';
import '../profs.dart'; // Importez la page de détails

class ProfsListPage extends StatelessWidget {
  const ProfsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Récupère la liste complète des professeurs
    List<Profs> allTeachers = Profs.getFictionalProfs();

    // Trie les professeurs par ordre alphabétique de leur nom (pname)
    allTeachers.sort((a, b) => a.pname.compareTo(b.pname));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tous nos Professeurs",
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
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 colonnes pour une bonne densité
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75, // Ratio pour la taille des cartes
          ),
          itemCount: allTeachers.length,
          itemBuilder: (context, index) {
            final prof = allTeachers[index];
            return _buildProfGridCard(context, prof); // Utilise une carte pour la GridView
          },
        ),
      ),
    );
  }

  // Fonction pour construire une carte de professeur pour la GridView
  // Cette fonction est identique à celle de FilesPage utilisée pour les petites cartes,
  // mais elle est ici pour la page de liste complète.
  Widget _buildProfGridCard(BuildContext context, Profs prof) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
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
                  prof.iconpath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.person,
                    size: 80,
                    color: Theme.of(context).iconTheme.color,
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
                      prof.pname,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge?.color,
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
                        color: Theme.of(context).textTheme.bodyMedium?.color,
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