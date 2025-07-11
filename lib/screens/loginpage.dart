import 'package:flutter/material.dart';
import 'package:lvlmindbeta/navbar/transition.dart';
import 'package:lvlmindbeta/screens/presentation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../animations/simpleDelayedAnimation.dart';
import '../services/authentificationService.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Permet au corps de s'étendre derrière l'AppBar transparente
      appBar: _buildAppBar(context), // Utilisation de la barre d'application refactorisée
      body: Stack(
        children: [
          // Éléments de décoration SVG en arrière-plan (sans animation directe ici, ils sont statiques)
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
            icon: Icon(
              Icons.close,
              color: Theme.of(context).appBarTheme.foregroundColor ?? Colors.blueAccent, // Couleur adaptée au thème
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
            padding: const EdgeInsets.only(top: 10, right: 15),
            child: Image(
              height: 50,
              image: const AssetImage('assets/images/logo/logomin.jpg'),
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.image_not_supported,
                color: Theme.of(context).iconTheme.color, // Couleur adaptée au thème
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
          // Section de texte d'introduction
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DelayedAnimation(
                  delay: 500,
                  curve: Curves.easeOutCubic,
                  slideStartOffset: const Offset(0.0, -0.2),
                  child: Text(
                    'Connectez-vous à LevelMind',
                    style: TextStyle(
                      fontFamily: 'PatrickHand',
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                DelayedAnimation(
                  delay: 700,
                  curve: Curves.easeOutQuad,
                  slideStartOffset: const Offset(0.0, -0.1),
                  child: Text(
                    "Il est recommandé de se connecter",
                    style: TextStyle(
                      fontFamily: 'Josefin',
                      fontSize: 20,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                DelayedAnimation(
                  delay: 800,
                  curve: Curves.easeOutQuad,
                  slideStartOffset: const Offset(0.0, -0.1),
                  child: Text(
                    "avec votre identifiant.",
                    style: TextStyle(
                      fontFamily: 'Josefin',
                      fontSize: 20,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          // Le formulaire de connexion (maintenant avec la logique d'authentification)
          const LoginForm(), // LoginForm est désormais une const
        ],
      ),
    );
  }
}

// Le formulaire de connexion (Matricule et Mot de passe)
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _matriculeController = TextEditingController(); // Renommé pour la clarté
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false; // Pour l'indicateur de chargement
  final AuthService _authService = AuthService(); // Instance du service d'authentification

  @override
  void dispose() {
    _matriculeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Méthode de connexion
  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Active l'indicateur de chargement
      });

      try {
        // Appel du service d'authentification avec le matricule et le mot de passe
        final user = await _authService.login(
          _matriculeController.text,
          _passwordController.text,
        );

        if (user != null) {
          if (!mounted) return; // Vérifie si le widget est toujours monté
          // Connexion réussie, navigue vers l'écran de transition
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Transition()),
          );
        } else {
          // Cela ne devrait pas être atteint si l'exception est lancée par AuthService
          _showErrorSnackBar('Numéro de matricule ou mot de passe incorrect.');
        }
      } catch (e) {
        if (!mounted) return;
        // Affiche le message d'erreur retourné par AuthService
        _showErrorSnackBar(e.toString().replaceFirst('Exception: ', ''));
      } finally {
        setState(() {
          _isLoading = false; // Désactive l'indicateur de chargement
        });
      }
    }
  }

  // Fonction utilitaire pour afficher les messages d'erreur
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                DelayedAnimation(
                  delay: 1000,
                  curve: Curves.easeOutCubic,
                  slideStartOffset: const Offset(0.0, 0.1),
                  child: TextFormField(
                    controller: _matriculeController, // Utilise le contrôleur pour le matricule
                    keyboardType: TextInputType.number, // Clavier numérique
                    decoration: InputDecoration(
                      labelText: 'Votre numéro de matricule (6 chiffres)', // Indication pour l'utilisateur
                      labelStyle: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).inputDecorationTheme.fillColor,
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
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(color: Colors.red, width: 2.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(color: Colors.red, width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre numéro de matricule';
                      }
                      // Validation: uniquement des chiffres et 6 caractères
                      if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
                        return 'Le matricule doit être un nombre de 6 chiffres';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                DelayedAnimation(
                  delay: 1200,
                  curve: Curves.easeOutCubic,
                  slideStartOffset: const Offset(0.0, 0.1),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe (min. 8 caractères)',
                      labelStyle: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,
                          color: Theme.of(context).iconTheme.color?.withOpacity(0.7),
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
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(color: Colors.red, width: 2.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(color: Colors.red, width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre mot de passe';
                      }
                      if (value.length < 8) {
                        return 'Le mot de passe doit contenir au moins 8 caractères';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          DelayedAnimation(
            delay: 1400,
            curve: Curves.bounceOut,
            animationDuration: const Duration(milliseconds: 1000),
            child: _isLoading // Affiche l'indicateur si en cours de chargement
                ? const CircularProgressIndicator()
                : ElevatedButton(
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
                  fontWeight: FontWeight.w800, // Poids de police plus fort pour le bouton
                ),
              ),
              onPressed: _login, // Appel de la méthode _login
            ),
          ),
          const SizedBox(height: 90),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 35),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const DelayedAnimation(
                  delay: 1600,
                  curve: Curves.easeOutCubic,
                  slideStartOffset: Offset(0.0, 0.1),
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