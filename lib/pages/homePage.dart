import 'package:flutter/material.dart';
import 'package:lvlmindbeta/pages/filesPage.dart';
import 'package:lvlmindbeta/Models/popuphome.dart';
import 'package:lvlmindbeta/Models/matiere.dart'; 

// Définition de la page d'accueil de l'application
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

// État de la page d'accueil
class _HomepageState extends State<Homepage> with AutomaticKeepAliveClientMixin {
  // Conserve l'état du widget même si la page n'est plus visible (ex: via BottomNavBar)
  @override
  bool get wantKeepAlive => true;

  // Listes pour les données du menu popup et des catégories
  List<Section> _sections = [];
  List<Secteur> _secteurs = []; // Renommée pour plus de clarté
  List<CategoryItemData> _categoriesData = []; // Données pour la grille de catégories

  @override
  void initState() {
    super.initState();
    _loadData(); // Charge les données une seule fois lors de l'initialisation de l'état
  }

  // Charge toutes les données nécessaires pour la page
  void _loadData() {
    setState(() {
      _sections = Section.getSections(); // Utilise getSections() de la classe Section améliorée
      _secteurs = Secteur.getFictionalSectors(); // Utilise getFictionalSectors() de la classe Secteur améliorée
      _categoriesData = _getCategoryItems(); // Charge les données pour la grille de catégories
    });
  }

  // Fonction utilitaire pour obtenir les données des éléments de catégorie
  static List<CategoryItemData> _getCategoryItems() {
    return const [
      CategoryItemData('assets/images/icons/Electronic.jpg', 'Électronique'),
      CategoryItemData('assets/images/icons/Programming.jpg', 'Programmation'),
      CategoryItemData('assets/images/icons/management.jpg', 'Gestion'),
      CategoryItemData('assets/images/icons/math.jpg', 'Mathématiques'),
      CategoryItemData('assets/images/icons/design.jpg', 'Design'), // Exemple d'ajout
      CategoryItemData('assets/images/icons/robotics.jpg', 'Robotique'), // Exemple d'ajout
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Nécessaire pour AutomaticKeepAliveClientMixin

    // Ne PAS appeler _loadData() ou getSection()/getSecteur() ici.
    // Ils sont déjà appelés dans initState et un appel ici provoquerait
    // des appels setState() infinis.

    final mediaQuery = MediaQuery.of(context);

    // Retourne le Scaffold principal avec une structure adaptée à la taille de l'écran
    // La logique responsive est gérée par des widgets flexibles ou des conditions
    return Scaffold(
      body: SingleChildScrollView( // Permet le défilement si le contenu dépasse la taille de l'écran
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column( // Utilisez Column car ListView est déjà le parent
          crossAxisAlignment: CrossAxisAlignment.start, // Alignement à gauche
          children: [
            // Bouton de menu (à améliorer pour être un bouton interactif)
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 50,
                child: Image.asset(
                  'assets/images/icons/menubutton.jpg',
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.menu),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Section de bienvenue avec avatar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded( // Permet au Text.rich de prendre l'espace disponible
                  child: Text.rich(
                    TextSpan(
                      text: "Salut ! \n\n", // Traduit "Hi there"
                      style: TextStyle(
                        fontFamily: 'Josefin',
                        color: Color.fromARGB(180, 0, 0, 0),
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                      children: [
                        TextSpan(
                          text: "Commençons une journée passionnante \n en apprenant avec nous", // Traduit le message
                          style: TextStyle(
                            fontFamily: 'Josefin',
                            fontSize: 17,
                            color: Color.fromARGB(171, 0, 0, 0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 90,
                  child: Image.asset(
                    'assets/images/icons/avatar1.jpg',
                    alignment: Alignment.topRight,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.person_outline, size: 90),
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
                  color: const Color.fromARGB(255, 121, 38, 238),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Action pour le bouton TOP
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Marge interne ajustée
                      child: Text(
                        "TOP",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Josefin',
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                // Menu glissant (matières principales)
                _BestSubjectsList(secteurs: _secteurs), // Passe la liste des secteurs

                // Bouton de menu contextuel (pour personnaliser les catégories)
                IconButton(
                  onPressed: () {
                    // Calculer la position du menu par rapport au bouton
                    final RenderBox button = context.findRenderObject() as RenderBox;
                    final Offset offset = button.localToGlobal(Offset.zero);
                    final Size buttonSize = button.size;

                    showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                        offset.dx, // Position X du bouton
                        offset.dy + buttonSize.height, // Position Y sous le bouton
                        mediaQuery.size.width - (offset.dx + buttonSize.width),
                        mediaQuery.size.height - (offset.dy + buttonSize.height),
                      ),
                      items: [
                        PopupMenuItem(
                          padding: EdgeInsets.zero, // Retire le padding par défaut
                          child: SizedBox(
                            width: 180, // Largeur fixe pour le menu popup
                            height: 180, // Hauteur fixe pour le menu popup
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                final sectionItem = _sections[index];
                                return ListTile(
                                  onTap: () {
                                    Navigator.pop(context); // Ferme le menu popup
                                    sectionItem.onTap?.call(); // Exécute l'action associée
                                  },
                                  title: Text(
                                    sectionItem.name,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 63, 63, 63),
                                      fontFamily: 'Josefin',
                                      fontSize: 15,
                                    ),
                                  ),
                                  leading: Icon(
                                    sectionItem.icon,
                                    size: 20,
                                    color: Colors.blueAccent, // Couleur d'icône pour le style
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
                  icon: const Icon(
                    Icons.filter_list, // Icône plus appropriée pour "filtrer" ou "personnaliser"
                    size: 28, // Taille de l'icône ajustée
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Titre de la section "Catégories"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Catégories", // Traduit "Category"
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Josefin',
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(166, 0, 0, 0),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Redirection vers une page contenant toutes les catégories (Matières)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Files()), // Redirection vers Files (qui liste les matières)
                    );
                  },
                  child: const Text(
                    "Voir tout", // Traduit "See all"
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Josefin',
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(223, 222, 75, 161),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15), // Espacement après le titre "Catégories"

            // Grille des catégories (Matières suggérées)
            SizedBox(
              height: 400, // Hauteur fixe pour la grille (ajuster si besoin)
              child: CategoryGridView(categories: _categoriesData), // Passe les données à la grille
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

  const _BestSubjectsList({required this.secteurs});

  @override
  Widget build(BuildContext context) {
    return Expanded( // Permet à cette liste de prendre l'espace restant
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
                // Action quand un secteur est tapé, par exemple filtrer les cours
                debugPrint("Secteur ${secteur.name} tapé!");
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12), // Padding pour le texte
                  child: Center( // Centre le texte dans le Card
                    child: Text(
                      secteur.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
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

// Données pour un élément de la grille de catégories
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
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 colonnes
        crossAxisSpacing: 10, // Espacement horizontal
        mainAxisSpacing: 10, // Espacement vertical
        childAspectRatio: 0.9, // Ajuste la hauteur des éléments si nécessaire
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final categoryItem = categories[index];
        return GestureDetector(
          onTap: () {
            // Action quand une catégorie est tapée, par exemple naviguer vers les cours de cette catégorie
            debugPrint("Catégorie ${categoryItem.title} tapée!");
            // Navigator.push(context, MaterialPageRoute(builder: (context) => MatiereScreen(categoryName: categoryItem.title)));
          },
          child: Card(
            elevation: 4, // Élévation légèrement augmentée
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Coins plus arrondis
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image de la catégorie
                Expanded( // Permet à l'image de prendre l'espace disponible
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      categoryItem.imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.category, size: 60, color: Colors.grey),
                    ),
                  ),
                ),
                // Titre de la catégorie
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0), // Padding sous le texte
                  child: Text(
                    categoryItem.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Josefin',
                      fontSize: 16, // Taille de police légèrement augmentée
                      fontWeight: FontWeight.w600, // Poids de police plus prononcé
                      color: Color.fromARGB(255, 65, 64, 64),
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