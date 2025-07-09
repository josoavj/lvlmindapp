import 'package:flutter/material.dart';
import 'package:lvlmindbeta/pages/filesPage.dart';
import 'package:lvlmindbeta/Models/popuphome.dart';
import 'package:lvlmindbeta/Models/matiere.dart';
import 'package:lvlmindbeta/pages/profilePage.dart';
import 'package:lvlmindbeta/services/authentificationService.dart';

import '../Models/screenModels/matiereDetails.dart';

// Définition de la page d'accueil de l'application
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

// État de la page d'accueil
class _HomepageState extends State<Homepage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // Listes de données
  List<Section> _sections = []; // Pour le menu popup et la liste horizontale des filtres
  List<Matiere> _allMatieres = []; // Toutes les matières disponibles
  List<Matiere> _displayedMatieres = []; // Les matières actuellement affichées dans la grille

  String? _activeFilterTag; // Le tag du filtre actif (null, "TOP", ou nom de section)
  String _userName = "Cher(ère) étudiant(e)";

  @override
  void initState() {
    super.initState();
    _loadInitialData(); // Charge toutes les données initiales
    _loadUserName(); // Charge le nom de l'utilisateur
  }

  // Charge toutes les données nécessaires au démarrage
  void _loadInitialData() {
    _sections = Section.getSections(context); // Obtient les sections/filtres
    _allMatieres = Matiere.getFictionalCourses(); // Obtient toutes les matières
    _applyFilter(null); // Applique le filtre initial (afficher tout)
  }

  // Charge le nom de l'utilisateur connecté
  Future<void> _loadUserName() async {
    final authService = AuthService();
    final user = await authService.getLoggedInUser();
    if (mounted && user != null) {
      setState(() {
        _userName = user.name.split(' ').first;
      });
    }
  }

  // Applique un filtre aux matières affichées
  void _applyFilter(String? filterTag) {
    setState(() {
      _activeFilterTag = filterTag;

      if (filterTag == null) {
        // Afficher toutes les matières si aucun filtre n'est sélectionné
        _displayedMatieres = List.from(_allMatieres);
      } else if (filterTag == 'TOP') {
        // Logique pour les matières "TOP" (exemple: les 5 premières, ou celles marquées comme top)
        // Vous pouvez ajouter une propriété `isTop: bool` à `Matiere` si vous voulez une logique plus complexe.
        _displayedMatieres = _allMatieres.take(5).toList(); // Exemple: les 5 premières matières
      } else {
        // Filtrer par le filterTag (nom de la section)
        _displayedMatieres = _allMatieres
            .where((matiere) => matiere.filterTag == filterTag)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final mediaQuery = MediaQuery.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Ouvre le Drawer
                  debugPrint("Bouton de menu tapé!");
                },
                icon: Icon(
                  Icons.menu,
                  size: 30,
                  color: colorScheme.onBackground,
                ),
              ),
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "Salut $_userName ! \n\n",
                      style: textTheme.titleLarge?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.9),
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                      children: [
                        TextSpan(
                          text: "Commençons une journée passionnante \n en apprenant avec nous",
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: 17,
                            color: colorScheme.onSurface.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Profile()),
                    );
                  },
                  child: SizedBox(
                    width: 90,
                    child: Image.asset(
                      'assets/images/icons/avatar1.jpg',
                      alignment: Alignment.topRight,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.person_outline,
                        size: 90,
                        color: colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Bouton "TOP"
                Card(
                  elevation: 5,
                  clipBehavior: Clip.antiAlias,
                  color: _activeFilterTag == 'TOP' ? colorScheme.primary : Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () => _applyFilter('TOP'), // Applique le filtre "TOP"
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        "TOP",
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium?.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: _activeFilterTag == 'TOP' ? colorScheme.onPrimary : colorScheme.onSurface.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                ),

                // Menu glissant (sections agissant comme filtres)
                _SectionsFilterList(
                  sections: _sections.where((s) => s.name != 'TOP').toList(), // Exclut "TOP" ici pour ne pas le dupliquer
                  activeFilterTag: _activeFilterTag,
                  onFilterSelected: _applyFilter,
                ),

                // Bouton de menu contextuel (pour choisir parmi toutes les sections, y compris "TOP" si désiré)
                Builder(
                  builder: (innerContext) {
                    return IconButton(
                      onPressed: () {
                        final RenderBox button = innerContext.findRenderObject() as RenderBox;
                        final Rect buttonRect = button.localToGlobal(Offset.zero) & button.size;

                        showMenu(
                          context: innerContext,
                          position: RelativeRect.fromRect(
                            buttonRect,
                            Offset.zero & mediaQuery.size,
                          ),
                          items: [
                            PopupMenuItem(
                              padding: EdgeInsets.zero,
                              child: SizedBox(
                                width: 180,
                                height: 180,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    final sectionItem = _sections[index];
                                    return ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        _applyFilter(sectionItem.name); // Applique le filtre de la section
                                      },
                                      title: Text(
                                        sectionItem.name,
                                        style: textTheme.bodyMedium?.copyWith(
                                          color: colorScheme.onSurface.withOpacity(0.8),
                                          fontSize: 15,
                                        ),
                                      ),
                                      leading: Icon(
                                        sectionItem.icon,
                                        size: 20,
                                        color: colorScheme.primary,
                                      ),
                                    );
                                  },
                                  itemCount: _sections.length,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      icon: Icon(
                        Icons.filter_list,
                        size: 28,
                        color: colorScheme.primary,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Matières", // Titre changé
                  textAlign: TextAlign.left,
                  style: textTheme.titleLarge?.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigue vers FilesPage qui listera toutes les matières
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Files()),
                    );
                  },
                  child: Text(
                    "Voir tout",
                    textAlign: TextAlign.left,
                    style: textTheme.titleMedium?.copyWith(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // Grille des matières filtrées
            SizedBox(
              height: mediaQuery.size.width > 400 ? 400 : 350,
              child: MatiereGridView(matieres: _displayedMatieres), // Passe les matières filtrées
            ),
          ],
        ),
      ),
    );
  }
}

// Widget pour la liste horizontale des filtres de sections
class _SectionsFilterList extends StatelessWidget {
  final List<Section> sections;
  final String? activeFilterTag;
  final Function(String?) onFilterSelected;

  const _SectionsFilterList({
    super.key,
    required this.sections,
    required this.activeFilterTag,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: SizedBox(
        height: 38,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          separatorBuilder: (context, index) => const SizedBox(width: 5),
          itemCount: sections.length,
          itemBuilder: (context, index) {
            final section = sections[index];
            final bool isActive = activeFilterTag == section.name;
            return GestureDetector(
              onTap: () => onFilterSelected(section.name), // Applique le filtre au clic
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                color: isActive ? colorScheme.primary : Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Center(
                    child: Text(
                      section.name,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isActive ? colorScheme.onPrimary : colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Widget pour la grille de matières
class MatiereGridView extends StatelessWidget {
  final List<Matiere> matieres;

  const MatiereGridView({super.key, required this.matieres});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.9,
      ),
      itemCount: matieres.length,
      itemBuilder: (context, index) {
        final matiere = matieres[index];
        return GestureDetector(
          onTap: () {
            debugPrint("Matière ${matiere.name} tapée!");
            // Navigue vers la page de détail de la matière
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MatiereDetailsPage(matiere: matiere)),
            );
          },
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      matiere.image, // Utilise le champ 'image' de Matiere
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.school,
                        size: 60,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                  child: Text(
                    matiere.name,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface.withOpacity(0.8),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}