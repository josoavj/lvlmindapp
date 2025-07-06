import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lvlmindbeta/navbar/navbar.dart';

class Transition extends StatefulWidget {
  const Transition({super.key});

  @override
  State<Transition> createState() => _TransitionState();
}

class _TransitionState extends State<Transition> {
  static const int _transitionDurationSeconds = 5;

  @override
  void initState() {
    super.initState();
    // Appel de la fonction de navigation après un délai lors de l'initialisation de l'état.
    _navigateToHome();
  }

  /// Fonction asynchrone pour gérer le délai et la navigation.
  /// Elle attend une durée définie puis navigue vers la page d'accueil.
  Future<void> _navigateToHome() async {
    // Attend la durée spécifiée.
    await Future.delayed(const Duration(seconds: _transitionDurationSeconds));

    // Vérifie si le widget est toujours monté avant d'effectuer la navigation.
    // Ceci est crucial pour éviter l'avertissement "use_build_context_synchronously"
    // et pour prévenir des erreurs si le widget est supprimé (par exemple, si l'utilisateur
    // quitte l'application) avant la fin du délai.
    if (!mounted) {
      return;
    }

    // Remplace la route actuelle par la route de la BottomNavBar.
    // pushReplacement empêche l'utilisateur de revenir à l'écran de transition via le bouton retour.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BottomNavBar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Le conteneur couvre toute la surface de l'écran.
        width: double.infinity,
        height: double.infinity,
        // Appel de la méthode pour la décoration de fond (dégradé et image).
        decoration: _buildBackgroundDecoration(context),
        child: Center(
          // Centre le contenu (logo et indicateur) verticalement et horizontalement.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centre les éléments verticalement.
            crossAxisAlignment: CrossAxisAlignment.center, // Centre les éléments horizontalement.
            children: [
              // Affiche le logo SVG de LevelMind.
              _buildLogo(), // Appel de la méthode pour le logo.
              const SizedBox(height: 50), // Espacement après le logo.

              // Ajout d'un indicateur de chargement circulaire pour une meilleure expérience utilisateur.
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  // Utilise la couleur "onPrimary" du thème pour contraster avec le fond.
                  Theme.of(context).colorScheme.onPrimary,
                ),
                strokeWidth: 4, // Épaisseur de la ligne de l'indicateur.
              ),
              const SizedBox(height: 20), // Espacement après l'indicateur.

              // Message de chargement pour informer l'utilisateur.
              Text(
                'Chargement de votre aventure...',
                style: TextStyle(
                  fontFamily: 'Josefin',
                  fontSize: 18,
                  // Utilise également la couleur "onPrimary" du thème pour le texte.
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Méthodes de construction des widgets pour une meilleure lisibilité ---

  /// Construit la décoration de fond du conteneur.
  /// Inclut un dégradé de couleurs et une image de fond assombrie.
  BoxDecoration _buildBackgroundDecoration(BuildContext context) {
    // Détermine les couleurs du dégradé en fonction de la luminosité du thème (mode clair/sombre).
    final Brightness brightness = Theme.of(context).brightness;
    final List<Color> gradientColors = brightness == Brightness.dark
        ? [const Color(0xFF0D1A3F), const Color(0xFF5D0E2B)] // Couleurs pour le mode sombre
        : const [Color(0xff2441e7), Color(0xffff1053)]; // Couleurs d'origine pour le mode clair

    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: gradientColors,
      ),
      image: DecorationImage(
        image: const AssetImage('assets/images/background/fond2.jpg'),
        fit: BoxFit.cover,
        // Applique un filtre de couleur pour assombrir l'image de fond,
        // la rendant plus lisible sous le texte et le logo.
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.5), // Surcouche noire à 50% d'opacité
          BlendMode.dstATop, // Mode de fusion
        ),
      ),
    );
  }

  /// Construit le widget du logo SVG.
  Widget _buildLogo() {
    return SvgPicture.asset(
      'assets/images/logo/LevelMind.svg',
      width: 250,
    );
  }
}