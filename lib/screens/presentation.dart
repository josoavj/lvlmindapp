import 'package:flutter/material.dart';
import 'package:lvlmindbeta/screens/loginpage.dart';
import 'package:lvlmindbeta/screens/redirecting.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../animations/simpleDelayedAnimation.dart';

class Presentation extends StatelessWidget {
  const Presentation({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenez les dimensions de l'écran une seule fois
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true, // Permet au corps de s'étendre derrière l'AppBar transparente
      appBar: _buildAppBar(context), // Utilisation de la barre d'application refactorisée
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        width: screenWidth,
        height: screenHeight,
        decoration: _buildBackgroundDecoration(), // Appel de la méthode pour le fond
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo de l'application
            DelayedAnimation(
              delay: 500, // Commence l'animation plus tôt
              curve: Curves.easeOutBack, // Effet de "recul" à l'arrivée
              slideStartOffset: const Offset(0.0, -0.5), // Vient du haut
              child: _buildLvlMinLogo(),
            ),
            const SizedBox(height: 30), // Espacement ajusté après le logo

            // Section de texte d'introduction
            DelayedAnimation(
              delay: 800, // Démarre après le logo
              curve: Curves.easeOutCubic, // Courbe douce
              child: _buildIntroTextSection(),
            ),
            const SizedBox(height: 40), // Espacement après la section de texte

            // Section des boutons (Login et Register)
            DelayedAnimation(
              delay: 1100, // Démarre après le texte d'introduction
              curve: Curves.bounceOut, // Effet de rebond pour les boutons
              animationDuration: const Duration(milliseconds: 1000), // Durée pour l'effet de rebond
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Column(
                  children: [
                    _buildLoginButton(context),
                    const SizedBox(height: 15),
                    _buildRegisterSection(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Méthodes de construction des widgets pour une meilleure lisibilité ---

  /// Construit la barre d'application transparente.
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0, // Pas d'ombre
      backgroundColor: Colors.transparent, // Rendre l'AppBar transparente
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white, // Icône blanche pour contraster avec le fond
          size: 30,
        ),
        onPressed: () {
          // Retourne à la page précédente (WelcomePage)
          Navigator.pop(context);
        },
      ),
    );
  }

  /// Construit la décoration du fond avec un dégradé et une image.
  BoxDecoration _buildBackgroundDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xff2441e7), Color(0xffff1053)],
      ),
      image: DecorationImage(
        image: const AssetImage('assets/images/background/fond1.jpg'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.5), // Assombrit l'image de fond
          BlendMode.dstATop,
        ),
      ),
    );
  }

  /// Construit le logo de l'application.
  SizedBox _buildLvlMinLogo() {
    return SizedBox(
      height: 140,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Image.asset(
          'assets/images/logo/lvlind10.jpg',
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.lightbulb_outline,
              color: Colors.white,
              size: 100,
            ); // Icône par défaut si l'image ne charge pas
          },
        ),
      ),
    );
  }

  /// Construit la section de texte d'introduction.
  Container _buildIntroTextSection() {
    return Container(
      alignment: Alignment.center,
      child: const Column(
        children: [
          Text(
            "Votre aventure commence ici et maintenant.", // Traduit le texte
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Josefin',
              fontSize: 35,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 40),
          Text(
            "Entraînez votre esprit pour acquérir plus de connaissances avec LevelMind.", // Traduit le texte
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Josefin',
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  /// Construit le bouton de connexion.
  ElevatedButton _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(), // Assurez-vous que LoginPage est const
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: Colors.white, // Fond blanc pour le bouton
        padding: const EdgeInsets.all(13),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GradientText(
            'Se connecter avec un ID personnel', // Traduit le texte du bouton
            style: const TextStyle(
              fontFamily: 'Josefin',
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            gradientType: GradientType.linear,
            colors: const [Color(0xff2441e7), Color(0xffff1053)],
          ),
        ],
      ),
    );
  }

  /// Construit la section d'enregistrement (texte et bouton).
  Row _buildRegisterSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Centrer les éléments
      children: [
        _buildRegisterIntroText(), // Texte "Pas de compte ?"
        const SizedBox(width: 5), // Espacement entre le texte et le bouton
        _buildRegisterButton(context), // Bouton "S'inscrire"
      ],
    );
  }

  /// Construit le texte d'introduction à l'enregistrement.
  Text _buildRegisterIntroText() {
    return const Text(
      "Pas encore de compte ?", // Traduit le texte
      style: TextStyle(
        fontFamily: 'Josefin',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }

  /// Construit le bouton d'enregistrement.
  TextButton _buildRegisterButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Redirecting(), // Assurez-vous que Redirecting est const
          ),
        );
      },
      child: const DelayedAnimation(
        delay: 0, // Le délai est géré par le parent DelayedAnimation de la section
        child: Text(
          "S'inscrire", // Traduit le texte du bouton
          style: TextStyle(
            fontFamily: 'Josefin',
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}