import 'package:flutter/material.dart';
import 'package:lvlmindbeta/models/screen_models/all_matiere_section.dart';
import 'package:lvlmindbeta/models/popup_home.dart';
import 'package:lvlmindbeta/models/matiere.dart';
import 'package:lvlmindbeta/pages/profile_page.dart';
import 'package:lvlmindbeta/services/app_initialization_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/screen_models/matiere_details.dart'; // Pour jsonEncode/jsonDecode

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<Section> _sections = [];
  List<Matiere> _allMatieres = [];
  List<Matiere> _displayedMatieres = [];

  String? _activeFilterTag;
  String _userName = "Cher(ère) étudiant(e)";

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _loadUserName();
  }

  // Charge toutes les données initiales, y compris les sections persistantes
  Future<void> _loadInitialData() async {
    await _loadSections(); // Charge les sections depuis la persistance
    _allMatieres = Matiere.getFictionalCourses();
    _applyFilter(null); // Applique le filtre initial (afficher tout)
  }

  // Charge le nom de l'utilisateur connecté
  Future<void> _loadUserName() async {
    final user = appInit.authService.getLoggedInUser();
    if (mounted && user != null) {
      setState(() {
        _userName = user.name.split(' ').first;
      });
    }
  }

  // --- Gestion de la persistance des sections ---
  Future<void> _loadSections() async {
    final prefs = await SharedPreferences.getInstance();
    final String? sectionsString = prefs.getString('sections_list');
    if (sectionsString != null) {
      final List<dynamic> jsonList = jsonDecode(sectionsString);
      setState(() {
        _sections = jsonList.map((json) => Section.fromJson(json)).toList();
      });
    } else {
      // Si aucune section n'est sauvegardée, initialiser avec des sections par défaut
      setState(() {
        _sections = [
          Section.fromIconData(name: 'TOP', icon: Icons.star),
          Section.fromIconData(name: 'Électronique', icon: Icons.electric_bolt),
          Section.fromIconData(
              name: 'Intelligence Artificielle', icon: Icons.psychology_alt),
          Section.fromIconData(name: 'Programmation', icon: Icons.code),
          Section.fromIconData(name: 'Design', icon: Icons.brush),
          Section.fromIconData(name: 'Gestion', icon: Icons.business_center),
          Section.fromIconData(name: 'Cybersécurité', icon: Icons.security),
          Section.fromIconData(name: 'Réseaux', icon: Icons.lan),
          Section.fromIconData(name: 'Cloud Computing', icon: Icons.cloud),
          Section.fromIconData(name: 'Big Data', icon: Icons.storage),
          Section.fromIconData(name: 'DevOps', icon: Icons.build),
          Section.fromIconData(name: 'Blockchain', icon: Icons.link),
          Section.fromIconData(
              name: 'Analyse de Données', icon: Icons.analytics),
          Section.fromIconData(
              name: 'Génie Logiciel', icon: Icons.precision_manufacturing),
          Section.fromIconData(name: 'Robotique', icon: Icons.android),
        ];
      });
      _saveSections(); // Sauvegarde les sections par défaut
    }
  }

  Future<void> _saveSections() async {
    final prefs = await SharedPreferences.getInstance();
    final String sectionsString =
        jsonEncode(_sections.map((s) => s.toJson()).toList());
    await prefs.setString('sections_list', sectionsString);
  }

  // --- Logique d'ajout et de suppression de sections ---
  Future<void> _addSection(String name, IconData icon) async {
    // Empêcher l'ajout de sections avec le même nom (sauf si c'est voulu)
    if (_sections.any((s) => s.name.toLowerCase() == name.toLowerCase())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Une section nommée "$name" existe déjà.')),
      );
      return;
    }

    setState(() {
      _sections.add(Section.fromIconData(name: name, icon: icon));
    });
    await _saveSections();
    _applyFilter(name); // Applique le filtre à la nouvelle section
  }

  Future<void> _deleteSection(Section sectionToDelete) async {
    setState(() {
      _sections.removeWhere((s) => s.name == sectionToDelete.name);
      if (_activeFilterTag == sectionToDelete.name) {
        _activeFilterTag =
            null; // Réinitialise le filtre si la section active est supprimée
      }
    });
    await _saveSections();
    _applyFilter(_activeFilterTag); // Réapplique le filtre
  }

  // Dialogue pour ajouter une nouvelle section
  Future<void> _showAddSectionDialog() async {
    String newSectionName = '';
    IconData? selectedIcon = Section.availableIcons.first; // Icône par défaut

    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          // Utiliser StatefulBuilder pour mettre à jour le dialogue
          builder: (context, setInnerState) {
            return AlertDialog(
              title: const Text('Ajouter une nouvelle section'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (value) {
                        newSectionName = value;
                      },
                      decoration:
                          const InputDecoration(labelText: 'Nom de la section'),
                    ),
                    const SizedBox(height: 15),
                    Text('Choisir une icône:',
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 150,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: Section.availableIcons.length,
                        itemBuilder: (context, index) {
                          final icon = Section.availableIcons[index];
                          return GestureDetector(
                            onTap: () {
                              setInnerState(() {
                                // Utilise setInnerState pour le dialogue
                                selectedIcon = icon;
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: selectedIcon == icon
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey[200],
                              child: Icon(icon,
                                  color: selectedIcon == icon
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Annuler'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                ),
                TextButton(
                  child: const Text('Ajouter'),
                  onPressed: () {
                    if (newSectionName.isNotEmpty && selectedIcon != null) {
                      _addSection(newSectionName, selectedIcon!);
                      Navigator.of(dialogContext).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Veuillez entrer un nom et choisir une icône.')),
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Applique un filtre aux matières affichées
  void _applyFilter(String? filterTag) {
    setState(() {
      _activeFilterTag = filterTag;

      if (filterTag == null) {
        _displayedMatieres = List.from(_allMatieres);
      } else if (filterTag == 'TOP') {
        _displayedMatieres = _allMatieres.take(5).toList();
      } else {
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
                  Scaffold.of(context).openDrawer();
                  debugPrint("Bouton de menu tapé!");
                },
                icon: Icon(
                  Icons.menu,
                  size: 30,
                  color: colorScheme.onSurface,
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
                        color: colorScheme.onSurface.withValues(alpha: 0.9),
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "Commençons une journée passionnante\nen apprenant avec nous",
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: 17,
                            color: colorScheme.onSurface.withValues(alpha: 0.7),
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
                        color: colorScheme.onSurface.withValues(alpha: 0.5),
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
                  color: _activeFilterTag == 'TOP'
                      ? colorScheme.primary
                      : Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () => _applyFilter('TOP'),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(
                        "TOP",
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium?.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: _activeFilterTag == 'TOP'
                              ? colorScheme.onPrimary
                              : colorScheme.onSurface.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                  ),
                ),

                // Menu glissant (sections agissant comme filtres)
                _SectionsFilterList(
                  sections: _sections.where((s) => s.name != 'TOP').toList(),
                  activeFilterTag: _activeFilterTag,
                  onFilterSelected: _applyFilter,
                  onSectionDeleted: _deleteSection,
                ),

                // Bouton de menu contextuel (pour choisir parmi toutes les sections et ajouter)
                Builder(
                  builder: (innerContext) {
                    return IconButton(
                      onPressed: () {
                        final RenderBox button =
                            innerContext.findRenderObject() as RenderBox;
                        final Rect buttonRect =
                            button.localToGlobal(Offset.zero) & button.size;

                        showMenu(
                          context: innerContext,
                          position: RelativeRect.fromRect(
                            buttonRect,
                            Offset.zero & mediaQuery.size,
                          ),
                          items: <PopupMenuEntry<dynamic>>[
                            PopupMenuItem(
                              child: ListTile(
                                leading:
                                    Icon(Icons.add, color: colorScheme.primary),
                                title: Text('Ajouter une section',
                                    style: textTheme.bodyMedium),
                                onTap: () {
                                  Navigator.pop(innerContext);
                                  _showAddSectionDialog();
                                },
                              ),
                            ),
                            const PopupMenuDivider(), // Séparateur

                            ..._sections.map((sectionItem) {
                              return PopupMenuItem(
                                value: sectionItem.name,
                                child: ListTile(
                                  leading: Icon(sectionItem.icon,
                                      size: 20, color: colorScheme.primary),
                                  title: Text(
                                    sectionItem.name,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.onSurface
                                          .withValues(alpha: 0.8),
                                      fontSize: 15,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context); // Ferme le menu
                                    _applyFilter(
                                        sectionItem.name); // Applique le filtre
                                  },
                                ),
                              );
                            }),
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
                  "Matières",
                  textAlign: TextAlign.left,
                  style: textTheme.titleLarge?.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface.withAlpha((1 * 0.8).round()),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllMatieresPage()),
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
              child: MatiereGridView(
                  matieres:
                      _displayedMatieres), // MatiereGridView est maintenant défini en dessous
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
  final Function(Section) onSectionDeleted;

  const _SectionsFilterList({
    required this.sections,
    required this.activeFilterTag,
    required this.onFilterSelected,
    required this.onSectionDeleted,
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
              onTap: () => onFilterSelected(section.name),
              onLongPress: () {
                // Permet la suppression par un appui long, sauf pour "TOP"
                if (section.name != 'TOP') {
                  // Empêche la suppression de la section "TOP"
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        title: const Text('Supprimer la section ?'),
                        content: Text(
                            'Voulez-vous vraiment supprimer la section "${section.name}" ?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Annuler'),
                            onPressed: () {
                              Navigator.of(dialogContext).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Supprimer'),
                            onPressed: () {
                              onSectionDeleted(
                                  section); // Appelle la fonction de suppression
                              Navigator.of(dialogContext).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: isActive
                    ? colorScheme.primary
                    : Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Center(
                    child: Text(
                      section.name,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isActive
                            ? colorScheme.onPrimary
                            : colorScheme.primary,
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

// Widget pour la grille de matières (solution pour le deuxième erreur)
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
              MaterialPageRoute(
                  builder: (context) => MatiereDetailsPage(matiere: matiere)),
            );
          },
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                  padding:
                      const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                  child: Text(
                    matiere.name,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface.withValues(alpha: 0.8),
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
