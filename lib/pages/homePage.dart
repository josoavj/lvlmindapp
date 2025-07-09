import 'package:flutter/material.dart';
import 'package:lvlmindbeta/pages/filesPage.dart';
import 'package:lvlmindbeta/Models/popuphome.dart';
import 'package:lvlmindbeta/Models/matiere.dart';
import 'package:lvlmindbeta/pages/profilePage.dart';
import 'package:lvlmindbeta/services/authentificationService.dart';

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

  List<Section> _sections = [];
  List<Secteur> _secteurs = [];
  List<CategoryItemData> _categoriesData = [];

  String _userName = "Cher(ère) étudiant(e)"; // Initialisation par défaut

  @override
  void initState() {
    super.initState();
    _loadData();
    _loadUserName(); // Charge le nom de l'utilisateur
  }

  // Charge toutes les données nécessaires pour la page
  void _loadData() {
    setState(() {
      _sections = Section.getSections();
      _secteurs = Secteur.getFictionalSectors();
      _categoriesData = _getCategoryItems();
    });
  }

  // Charge le nom de l'utilisateur connecté
  Future<void> _loadUserName() async {
    final authService = AuthService(); // Créez une instance de votre AuthService
    final user = await authService.getLoggedInUser();
    if (mounted && user != null) {
      setState(() {
        _userName = user.name.split(' ').first; // Affiche seulement le prénom
      });
    }
  }

  // Fonction utilitaire pour obtenir les données des éléments de catégorie
  static List<CategoryItemData> _getCategoryItems() {
    return const [
      CategoryItemData('assets/images/icons/Electronic.jpg', 'Électronique'),
      CategoryItemData('assets/images/icons/Programming.jpg', 'Programmation'),
      CategoryItemData('assets/images/icons/management.jpg', 'Gestion'),
      CategoryItemData('assets/images/icons/math.jpg', 'Mathématiques'),
      CategoryItemData('assets/images/icons/design.jpg', 'Design'),
      CategoryItemData('assets/images/icons/robotics.jpg', 'Robotique'),
    ];
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
            // Bouton de menu
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  // TODO: Implémenter l'ouverture d'un Drawer ou d'un menu latéral
                  Scaffold.of(context).openDrawer(); // Nécessite un Drawer dans le Scaffold parent (ex: dans BottomNavBar ou dans main.dart)
                  debugPrint("Bouton de menu tapé!");
                },
                icon: Icon(
                  Icons.menu,
                  size: 30, // Taille ajustée pour la visibilité
                  color: colorScheme.onBackground, // Couleur cohérente avec le thème
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Section de bienvenue avec avatar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "Salut $_userName ! \n\n", // Affiche le nom de l'utilisateur
                      style: textTheme.titleLarge?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.9), // Couleur du thème
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                      children: [
                        TextSpan(
                          text: "Commençons une journée passionnante \n en apprenant avec nous",
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: 17,
                            color: colorScheme.onSurface.withOpacity(0.7), // Couleur du thème
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector( // Rend l'avatar cliquable
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Profile()),
                    );
                  },
                  child: SizedBox(
                    width: 90,
                    child: Image.asset(
                      'assets/images/icons/avatar1.jpg', // Votre image d'avatar
                      alignment: Alignment.topRight,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.person_outline,
                        size: 90,
                        color: colorScheme.onSurface.withOpacity(0.5), // Couleur du thème
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),

            // Section Catégories (TOP / Menu glissant / Menu contextuel)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Bouton "TOP"
                Card(
                  elevation: 5,
                  clipBehavior: Clip.antiAlias,
                  color: colorScheme.primary, // Utilise la couleur primaire du thème (BlueAccent)
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Action pour le bouton TOP
                      debugPrint("Bouton TOP tapé!");
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        "TOP",
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium?.copyWith(
                          fontFamily: 'Josefin', // Conserve Josefin si override global échoue
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onPrimary, // Texte blanc sur la couleur primaire
                        ),
                      ),
                    ),
                  ),
                ),

                // Menu glissant (matières principales)
                _BestSubjectsList(secteurs: _secteurs),

                // Bouton de menu contextuel (pour personnaliser les catégories)
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
                                        sectionItem.onTap?.call();
                                      },
                                      title: Text(
                                        sectionItem.name,
                                        style: textTheme.bodyMedium?.copyWith(
                                          color: colorScheme.onSurface.withOpacity(0.8), // Couleur du thème
                                          fontSize: 15,
                                        ),
                                      ),
                                      leading: Icon(
                                        sectionItem.icon,
                                        size: 20,
                                        color: colorScheme.primary, // Couleur primaire du thème
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
                        color: colorScheme.primary, // Couleur primaire du thème
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Titre de la section "Catégories"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Catégories",
                  textAlign: TextAlign.left,
                  style: textTheme.titleLarge?.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface.withOpacity(0.8), // Couleur du thème
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Files()), // Utilisez const si Files est stateless
                    );
                  },
                  child: Text(
                    "Voir tout",
                    textAlign: TextAlign.left,
                    style: textTheme.titleMedium?.copyWith(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.secondary, // Utilise la couleur secondaire (rose) du thème
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // Grille des catégories (Matières suggérées)
            SizedBox(
              height: mediaQuery.size.width > 400 ? 400 : 350,
              child: CategoryGridView(categories: _categoriesData),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Widgets enfants refactorisés ---

// Widget pour la liste horizontale des "meilleures" matières (secteurs)
class _BestSubjectsList extends StatelessWidget {
  final List<Secteur> secteurs;

  const _BestSubjectsList({super.key, required this.secteurs}); // Ajout de super.key

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
          itemCount: secteurs.length,
          itemBuilder: (context, index) {
            final secteur = secteurs[index];
            return GestureDetector(
              onTap: () {
                debugPrint("Secteur ${secteur.name} tapé!");
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Center(
                    child: Text(
                      secteur.name,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        fontFamily: 'Josefin',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.primary, // Utilise la couleur primaire du thème
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

// Données pour un élément de la grille de catégories (inchangé)
class CategoryItemData {
  final String imagePath;
  final String title;

  const CategoryItemData(this.imagePath, this.title);
}

// Widget pour la grille de suggestion des matières (catégories)
class CategoryGridView extends StatelessWidget {
  final List<CategoryItemData> categories;

  const CategoryGridView({super.key, required this.categories});

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
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final categoryItem = categories[index];
        return GestureDetector(
          onTap: () {
            debugPrint("Catégorie ${categoryItem.title} tapée!");
            // Exemple de navigation:
            // Navigator.push(context, MaterialPageRoute(builder: (context) => MatiereScreen(categoryName: categoryItem.title)));
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
                      categoryItem.imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.category,
                        size: 60,
                        color: Theme.of(context).iconTheme.color, // Utilise la couleur d'icône du thème
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    categoryItem.title,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      fontFamily: 'Josefin',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface.withOpacity(0.8), // Utilise la couleur du thème
                    ),
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