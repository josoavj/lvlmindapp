import 'package:flutter/material.dart';
import 'package:lvlmindbeta/screens/presentation.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../animations/simple_delayed_animation.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenez les dimensions de l'écran une seule fois
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white, // Couleur de fond du Scaffold
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 50),
              width: screenWidth,
              height: screenHeight,
              decoration:
                  _buildBackgroundDecoration(), // Appel de la méthode pour le fond
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo de l'ISPM et du LevelMind
                  _buildLogoList(),
                  const SizedBox(height: 20),

                  // Phrase d'introduction
                  // Utilisation d'une courbe plus douce pour l'apparition du texte
                  DelayedAnimation(
                    delay: 900, // Légèrement augmenté pour un meilleur timing
                    curve: Curves
                        .easeOutQuad, // Une courbe d'accélération/décélération douce
                    child: Flexible(
                      flex: 1,
                      child: _buildIntroText(),
                    ),
                  ),

                  // Titre LevelMind (SVG)
                  // Animation légèrement plus rapide et avec un léger rebond pour le titre
                  DelayedAnimation(
                    delay: 1000, // Démarre un peu après le texte d'intro
                    curve: Curves.elasticOut, // Effet "élastique" à la fin
                    animationDuration: const Duration(
                        milliseconds:
                            1200), // Durée plus longue pour l'effet élastique
                    child: _buildLvlMindNameSvg(),
                  ),

                  // Slogan
                  DelayedAnimation(
                    delay: 1200, // Démarre après le titre LevelMind
                    curve: Curves.easeOutCubic, // Courbe un peu plus prononcée
                    child: _buildSloganText(),
                  ),

                  // Bouton "Get Started"
                  DelayedAnimation(
                    delay: 1400, // Démarre après le slogan
                    curve: Curves.bounceOut, // Effet de rebond pour le bouton
                    animationDuration: const Duration(
                        milliseconds: 1000), // Durée pour l'effet de rebond
                    child: SizedBox(
                      width: double.infinity,
                      child: _buildStartButton(context),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // --- Méthodes de construction des widgets pour une meilleure lisibilité ---

  /// Construit la décoration du fond avec un dégradé et une image.
  BoxDecoration _buildBackgroundDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xff2441e7), Color(0xffff1053)],
      ),
      image: DecorationImage(
        image: const AssetImage('assets/images/background/fond2.jpg'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withValues(alpha: 0.5), // Assombrit l'image de fond
          BlendMode.dstATop,
        ),
      ),
    );
  }

  /// Construit la ligne des logos (ISPM et LvlMind).
  Row _buildLogoList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Logo de l'ISPM
        DelayedAnimation(
          delay: 500,
          curve: Curves.easeOutBack,
          slideStartOffset: const Offset(-0.5, 0.0),
          child: SizedBox(
            height: 85,
            child: Image.asset(
              'assets/images/logo/ispm.jpg',
              errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.school,
                  color: Colors.white,
                  size: 85), // Icône par défaut
            ),
          ),
        ),
        // Espacement entre les deux logos
        const SizedBox(width: 70),
        // Notre logo d'application
        DelayedAnimation(
          delay: 700,
          curve: Curves.easeOutBack,
          slideStartOffset: const Offset(0.5, 0.0),
          child: Flexible(
            flex: 2,
            child: SizedBox(
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/logo/lvlind10.jpg',
                  errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.lightbulb_outline,
                      color: Colors.white,
                      size: 80), // Icône par défaut
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Construit la phrase d'introduction.
  Container _buildIntroText() {
    return Container(
      margin: const EdgeInsets.only(top: 50, bottom: 30),
      child: const Text(
        'Apprentissage en ligne avec',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Josefin',
          fontSize: 30,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }

  /// Construit le titre LvlMind à partir d'un fichier SVG.
  Container _buildLvlMindNameSvg() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: SvgPicture.asset(
        'assets/images/logo/LevelMind.svg',
        width: 250,
        alignment: Alignment.bottomCenter,
      ),
    );
  }

  /// Construit le slogan de l'application.
  Container _buildSloganText() {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 20),
      child: const Text(
        "Développez vos compétences avec des cours, des certificats et des diplômes en ligne des universités de renommée mondiale.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Josefin',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  /// Construit le bouton "Commencer" (Get Started).
  ElevatedButton _buildStartButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.all(13),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const Presentation(), // Redirection vers la page de présentation
          ),
        );
      },
      child: GradientText(
        'COMMENCER',
        style: const TextStyle(
          fontFamily: 'TiltNeon',
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        gradientType: GradientType.linear,
        colors: const [Color(0xff2441e7), Color(0xffff1053)],
      ),
    );
  }
}
