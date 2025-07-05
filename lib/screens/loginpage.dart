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
          Padding( // <-- 'const' a été retiré ici
            padding: const EdgeInsets.only(top: 10, right: 15),
            child: Image(
              height: 50,
              image: const AssetImage('assets/images/logo/logomin.jpg'),
              errorBuilder: (context, error, stackTrace) => const Icon(
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
    return const SingleChildScrollView( // Peut être const car LoginForm est maintenant const
      child: Column(
        children: [
          // Section de texte d'introduction
          Padding(
            padding: EdgeInsets.only(top: 100, left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DelayedAnimation(
                  delay: 800,
                  child: Text(
                    'Connectez-vous à LevelMind',
                    style: TextStyle(
                      fontFamily: 'PatrickHand',
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 22),
                DelayedAnimation(
                  delay: 850,
                  child: Text(
                    "Il est recommandé de se connecter",
                    style: TextStyle(
                      fontFamily: 'Josefin',
                      fontSize: 20,
                      color: Color.fromARGB(95, 15, 12, 199),
                    ),
                  ),
                ),
                DelayedAnimation(
                  delay: 850,
                  child: Text(
                    "avec votre identifiant.",
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
          SizedBox(height: 30),
          LoginForm(), // Le formulaire de connexion (maintenant avec les boutons)
        ],
      ),
    );
  }
}

// Le formulaire de connexion (Email/ID et Mot de passe)
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>(); // Clé globale pour le formulaire
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true; // Pour masquer/afficher le mot de passe

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form( // Le widget Form pour la validation
      key: _formKey, // Associe la clé au formulaire
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                DelayedAnimation(
                  delay: 1000,
                  child: TextFormField( // Changé de TextField à TextFormField
                    controller: _idController, // Associe le contrôleur
                    decoration: InputDecoration(
                      labelText: 'Votre identifiant',
                      labelStyle: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(90, 212, 212, 212),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(
                          color: Colors.blueAccent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) { // Ajout du validateur
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre identifiant';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                DelayedAnimation(
                  delay: 1050,
                  child: TextFormField( // Changé de TextField à TextFormField
                    controller: _passwordController, // Associe le contrôleur
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      labelStyle: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(90, 212, 212, 212),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,
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
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(
                          color: Colors.blueAccent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) { // Ajout du validateur
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre mot de passe';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50), // Espacement avant le bouton CONFIRMER
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
                'CONFIRMER',
                style: TextStyle(
                  fontFamily: 'Josefin',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                // Valide le formulaire
                if (_formKey.currentState!.validate()) {
                  // Si la validation réussit, navigue vers la page de transition
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Transition(),
                    ),
                  );
                }
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
                  Navigator.pop(context);
                },
                child: const DelayedAnimation(
                  delay: 1100,
                  child: Text(
                    "Retour",
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