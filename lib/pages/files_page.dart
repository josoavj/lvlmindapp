import 'package:flutter/material.dart';
import 'package:lvlmindbeta/models/profs.dart';
import 'package:lvlmindbeta/models/matiere.dart';
import '../models/screen_models/matiere_details.dart';
import '../models/screen_models/matieres_list.dart';
import '../models/screen_models/profs_list.dart';
import '../screens/profs_details.dart';

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
      appBar: _buildAppBar(context),
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
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfsListPage()),
                  );
                },
                child: Text(
                  "Voir tout",
                  style: TextStyle(
                    fontFamily: 'Josefin',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context)
                        .textButtonTheme
                        .style
                        ?.foregroundColor
                        ?.resolve({WidgetState.selected}),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              itemCount: _professeurs.length,
              separatorBuilder: (context, index) => const SizedBox(width: 20),
              itemBuilder: (context, index) {
                final prof = _professeurs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfDetailsPage(prof: prof)),
                    );
                  },
                  child: Card(
                    color: Theme.of(context).cardColor,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: SizedBox(
                      width: 150,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: Image.asset(
                              prof.iconpath,
                              fit: BoxFit.cover,
                              height: 120,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.person_pin,
                                  color: Theme.of(context).iconTheme.color,
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
                                  prof.pname,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Josefin',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.color,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  prof.profeducation.split(',').first,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Josefin',
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color,
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Matières",
                style: TextStyle(
                  fontFamily: 'Josefin',
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Redirection vers la MatieresListPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MatieresListPage()),
                  );
                },
                child: Text(
                  "Voir tout",
                  style: TextStyle(
                    fontFamily: 'Josefin',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context)
                        .textButtonTheme
                        .style
                        ?.foregroundColor
                        ?.resolve({WidgetState.selected}),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Liste verticale des matières (inchangée, mais le onTap changera)
          SizedBox(
            height:
                450, // Peut-être agrandir si vous avez beaucoup de matières pour éviter le scroll
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              itemCount: _matieres.length,
              itemBuilder: (context, index) {
                final matiere = _matieres[index];
                return Card(
                  color: Theme.of(context).cardColor,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: ListTile(
                    onTap: () {
                      // Navigue vers la MatiereDetailsPage en passant l'objet matiere
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MatiereDetailsPage(matiere: matiere)),
                      );
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
                            color: Theme.of(context).iconTheme.color,
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
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    trailing: Text(
                      matiere.chapterCount.toString(),
                      style: const TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 13,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          // --- FIN DE LA SECTION "MATIERES" ---
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        'Matières',
        style: TextStyle(
          fontFamily: 'Josefin',
          fontSize: 22,
          color: Theme.of(context).appBarTheme.foregroundColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
