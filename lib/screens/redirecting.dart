import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/link.dart';

import '../animations/simpleDelayedAnimation.dart'; // Assurez-vous que url_launcher est bien dans pubspec.yaml

class Redirecting extends StatelessWidget {
  const Redirecting({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Définir des valeurs responsives
    final bool isLargeScreen = screenWidth > 600; // Seuil pour "grand écran"
    final double horizontalPadding = isLargeScreen ? 80.0 : 40.0;
    final double verticalPadding = isLargeScreen ? 200.0 : 150.0;
    final double logoHeight = isLargeScreen ? 100.0 : 80.0;
    final double logoSpacing = isLargeScreen ? 50.0 : 30.0;
    final double sponsoredFontSize = isLargeScreen ? 20.0 : 16.0;
    final double ispmFontSize = isLargeScreen ? 28.0 : 22.0;
    final double learningSloganFontSize = isLargeScreen ? 18.0 : 14.0;
    final double accountTextFontSize = isLargeScreen ? 17.0 : 14.0;
    final double createButtonFontSize = isLargeScreen ? 16.0 : 13.0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context), // AppBar unifiée
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        width: screenWidth,
        height: screenHeight,
        decoration: _buildBackgroundDecoration(), // Fond unifié

        child: Center(
          child: DelayedAnimation(
            delay: 700,
            curve: Curves.easeOutCubic, // Animation d'entrée pour la carte
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              // Couleur de la carte adaptée au thème
              color: Theme.of(context).cardColor.withOpacity(0.8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // La colonne prendra juste la taille nécessaire
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logos ISPM et LvlMind
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo/ispm.jpg',
                          height: logoHeight,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.school,
                              color: Theme.of(context).iconTheme.color,
                              size: logoHeight * 0.8,
                            );
                          },
                        ),
                        SizedBox(width: logoSpacing),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/logo/lvlind10.jpg',
                            height: logoHeight,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.lightbulb_outline,
                                color: Theme.of(context).iconTheme.color,
                                size: logoHeight * 0.8,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20), // Espacement après les logos

                    // Section "Sponsored By ISPM"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sponsorisé par', // Traduction
                          style: TextStyle(
                            fontFamily: 'Josefin',
                            fontSize: sponsoredFontSize,
                            color: Theme.of(context).textTheme.bodyLarge?.color, // Couleur adaptée au thème
                          ),
                        ),
                        const SizedBox(width: 10),
                        GradientText(
                          'ISPM',
                          style: TextStyle(
                            fontFamily: 'Josefin',
                            fontSize: ispmFontSize,
                            fontWeight: FontWeight.w800,
                          ),
                          gradientType: GradientType.linear,
                          // Couleurs du dégradé adaptées pour être visibles sur fond clair/sombre
                          colors: [
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white // Plus clair en mode sombre
                                : const Color.fromARGB(189, 0, 0, 0), // Plus sombre en mode clair
                            const Color.fromARGB(255, 19, 121, 41), // Vert fixe
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10), // Espacement après le sponsor

                    // Slogan "Online learning with us"
                    Text(
                      "L'apprentissage en ligne avec nous", // Traduction
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: learningSloganFontSize,
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).textTheme.bodyMedium?.color, // Couleur adaptée au thème
                      ),
                    ),
                    const SizedBox(height: 60), // Espacement avant le lien

                    // Section "Don't have an account?"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pas encore de compte ?", // Traduction
                          style: TextStyle(
                            fontFamily: 'Josefin',
                            fontSize: accountTextFontSize,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).textTheme.bodyLarge?.color, // Couleur adaptée au thème
                          ),
                        ),
                        const SizedBox(width: 5), // Espacement entre le texte et le bouton
                        Link(
                          uri: Uri.https('github.com', 'josoavj/lvlmindapp'), // Votre lien GitHub
                          target: LinkTarget.blank, // Ouvre dans un nouvel onglet/navigateur
                          builder: (context, followLink) => TextButton(
                            onPressed: followLink, // Utilise la fonction fournie par Link
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero, // Supprime le padding par défaut du TextButton si désiré
                              minimumSize: Size.zero, // Supprime la taille minimale
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Réduit la zone de tap
                            ),
                            child: Text(
                              'Créer', // Traduction du bouton
                              style: TextStyle(
                                fontFamily: 'Josefin',
                                color: Theme.of(context).textButtonTheme.style?.foregroundColor?.resolve({MaterialState.selected}), // Couleur adaptée au thème
                                fontSize: createButtonFontSize,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Barre d'application transparente.
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.close,
          color: Theme.of(context).appBarTheme.foregroundColor, // Couleur adaptée au thème
          size: 30,
        ),
        onPressed: () {
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
          Colors.black.withOpacity(0.5),
          BlendMode.dstATop,
        ),
      ),
    );
  }
}