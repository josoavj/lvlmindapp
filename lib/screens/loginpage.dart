import 'package:flutter/material.dart';
import 'package:lvlmindbeta/animations/simpleDelayedAnimation.dart'; // Assurez-vous que ce chemin est correct
import 'package:lvlmindbeta/navbar/transition.dart'; // Assurez-vous que ce chemin est correct
import 'package:lvlmindbeta/screens/presentation.dart'; // Assurez-vous que ce chemin est correct
import 'package:flutter_svg/flutter_svg.dart'; // Assurez-vous que ce package est bien installé

// La page de connexion de l'application
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Permet au corps de s'étendre derrière l'AppBar transparente
      appBar: _buildAppBar(context), // Utilisation de la barre d'application refactorisée
      body: Stack(
        children: [
          // Éléments de décoration SVG en arrière-plan
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              'assets/images/decoration/Vector.svg',
              width: 150,
              fit: BoxFit.fitHeight,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              'assets/images/decoration/Vector (1).svg',
              width: 200,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(
              'assets/images/decoration/Vector (2).svg',
              width: 150,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(
              'assets/images/decoration/Ellipse.svg',
              width: 200,
            ),
          ),
          // Contenu principal de la page de connexion
          _buildLoginBody(context),
        ],
      ),
    );
  }

  // --- Méthodes de construction des widgets pour une meilleure lisibilité ---

  /// Construit la barre d'application pour la page de connexion.
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0, // Pas d'ombre
      backgroundColor: Colors.transparent, // Rendre l'AppBar transparente
      automaticallyImplyLeading: false, // Ne pas afficher le bouton retour automatique
      titleSpacing: 0, // Supprime l'espacement par défaut du titre
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Bouton de fermeture
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.blueAccent,
              size: 25,
            ),
            onPressed: () {
              // Retourne à la page de présentation
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Presentation(),
                ),
              );
            },
          ),
          // Logo de l'application
          Padding(
            padding: EdgeInsets.only(top: 10, right: 15), // Ajuste le padding
            child: Image(
              height: 50,
              image: AssetImage('assets/images/logo/logomin.jpg'),
              // Ajoute un errorBuilder pour gérer les images manquantes
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.image_not_supported,
                color: Colors.grey,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Construit le corps principal de la page de connexion.
  SingleChildScrollView _buildLoginBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 100, left: 30, right: 30), // Padding ajusté
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Aligne le texte à gauche
              children: [
                const DelayedAnimation(
                  delay: 800,
                  child: Text(
                    'Connectez-vous à LevelMind', // Traduit le texte
                    style: TextStyle(
                      fontFamily: 'PatrickHand',
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87, // Couleur du texte
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                const DelayedAnimation(
                  delay: 850,
                  child: Text(
                    "Il est recommandé de se connecter", // Traduit le texte
                    style: TextStyle(
                      fontFamily: 'Josefin',
                      fontSize: 20,
                      color: Color.fromARGB(95, 15, 12, 199),
                    ),
                  ),
                ),
                const DelayedAnimation(
                  delay: 850,
                  child: Text(
                    "avec votre identifiant.", // Traduit le texte
                    style: TextStyle(
                      fontFamily: 'Josefin',
                      fontSize: 20,
                      color: Color.fromARGB(95, 15, 12, 199),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30), // Espacement après le texte d'introduction
          const LoginForm(), // Le formulaire de connexion
          const SizedBox(height: 50),
          DelayedAnimation(
            delay: 1100,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: const Color.fromARGB(225, 249, 29, 88),
                padding: const EdgeInsets.symmetric(
                  horizontal: 90,
                  vertical: 15,
                ),
              ),
              child: const Text(
                'CONFIRMER', // Traduit le texte du bouton
                style: TextStyle(
                  fontFamily: 'Josefin',
                  color: Colors.white, // Couleur du texte du bouton
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                // Navigue vers la page de transition après la connexion
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Transition(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 90),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 35),
              child: TextButton(
                onPressed: () {
                  // Retourne à la page de présentation
                  Navigator.pop(context); // Pop la route actuelle
                },
                child: const DelayedAnimation(
                  delay: 1100,
                  child: Text(
                    "Retour", // Traduit le texte du bouton
                    style: TextStyle(
                      fontFamily: 'Josefin',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Le formulaire de connexion (Email/ID et Mot de passe)
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState(); // Correction du nom de la classe d'état
}

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true; // Pour masquer/afficher le mot de passe

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          DelayedAnimation(
            delay: 1000,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Votre identifiant', // Traduit le label
                labelStyle: TextStyle(
                  fontFamily: 'Josefin',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600], // Couleur du label ajustée
                ),
                filled: true,
                fillColor: const Color.fromARGB(90, 212, 212, 212),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide.none, // Pas de bordure visible
                ),
                enabledBorder: OutlineInputBorder( // Bordure quand le champ n'est pas focus
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder( // Bordure quand le champ est focus
                  borderRadius: BorderRadius.circular(100),
                  borderSide: const BorderSide(
                    color: Colors.blueAccent, // Couleur de la bordure en focus
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          DelayedAnimation(
            delay: 1050,
            child: TextField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: 'Mot de passe', // Traduit le label
                labelStyle: TextStyle(
                  fontFamily: 'Josefin',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600], // Couleur du label ajustée
                ),
                filled: true,
                fillColor: const Color.fromARGB(90, 212, 212, 212),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility, // Change l'icône
                    color: const Color.fromARGB(255, 82, 141, 243),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide.none, // Pas de bordure visible
                ),
                enabledBorder: OutlineInputBorder( // Bordure quand le champ n'est pas focus
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder( // Bordure quand le champ est focus
                  borderRadius: BorderRadius.circular(100),
                  borderSide: const BorderSide(
                    color: Colors.blueAccent, // Couleur de la bordure en focus
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}