import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lvlmindbeta/animations/simple_delayed_animation.dart';
import 'package:lvlmindbeta/services/app_initialization_service.dart';
import 'package:lvlmindbeta/utils/form_validators.dart';
import 'package:lvlmindbeta/utils/error_handler.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _matriculeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _matriculeController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Méthode d'enregistrement
  void _register() async {
    if (_formKey.currentState!.validate()) {
      // Vérifier que les mots de passe correspondent
      if (_passwordController.text != _confirmPasswordController.text) {
        ErrorHandler.showErrorSnackBar(
            context, 'Les mots de passe ne correspondent pas');
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        await appInit.authService.register(
          username: _matriculeController.text,
          password: _passwordController.text,
          name: _nameController.text,
          email: _emailController.text,
          status: 'Étudiant',
          matricule: _matriculeController.text,
          establishment: 'LvlMind Academy',
        );

        if (!mounted) return;
        ErrorHandler.showSuccessSnackBar(
            context, 'Compte créé avec succès ! Connexion...');

        // Rediriger vers la page d'accueil après enregistrement
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.pushReplacementNamed(context, '/transition');
          }
        });
      } catch (e) {
        if (!mounted) return;
        ErrorHandler.showErrorSnackBar(context, e.toString());
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          // Décoration SVG en arrière-plan
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              'assets/images/decoration/Vector.svg',
              width: 150,
              fit: BoxFit.fitHeight,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(
              'assets/images/decoration/Ellipse.svg',
              width: 200,
            ),
          ),
          // Contenu principal
          _buildRegistrationBody(context),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).appBarTheme.foregroundColor ??
                  Colors.blueAccent,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 15),
            child: Image(
              height: 50,
              image: const AssetImage('assets/images/logo/logomin.jpg'),
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.image_not_supported,
                color: Theme.of(context).iconTheme.color,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView _buildRegistrationBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Section d'introduction
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
                    'Créer un compte',
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
                    "Rejoignez LevelMind",
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
                    "et commencez votre apprentissage.",
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
          _buildRegistrationForm(),
        ],
      ),
    );
  }

  Form _buildRegistrationForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                // Matricule
                DelayedAnimation(
                  delay: 1000,
                  curve: Curves.easeOutCubic,
                  slideStartOffset: const Offset(0.0, 0.1),
                  child: TextFormField(
                    controller: _matriculeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Numéro de matricule (6 chiffres)',
                      labelStyle: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .inputDecorationTheme
                            .labelStyle
                            ?.color,
                      ),
                      filled: true,
                      fillColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
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
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                      ),
                    ),
                    validator: (value) =>
                        FormValidators.validateMatricule(value),
                  ),
                ),
                const SizedBox(height: 20),
                // Nom
                DelayedAnimation(
                  delay: 1100,
                  curve: Curves.easeOutCubic,
                  slideStartOffset: const Offset(0.0, 0.1),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nom complet',
                      labelStyle: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .inputDecorationTheme
                            .labelStyle
                            ?.color,
                      ),
                      filled: true,
                      fillColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
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
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Le nom est requis';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Email
                DelayedAnimation(
                  delay: 1200,
                  curve: Curves.easeOutCubic,
                  slideStartOffset: const Offset(0.0, 0.1),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Adresse email',
                      labelStyle: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .inputDecorationTheme
                            .labelStyle
                            ?.color,
                      ),
                      filled: true,
                      fillColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
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
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'L\'email est requis';
                      }
                      if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value)) {
                        return 'Email invalide';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Mot de passe
                DelayedAnimation(
                  delay: 1300,
                  curve: Curves.easeOutCubic,
                  slideStartOffset: const Offset(0.0, 0.1),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe (min. 8 caractères)',
                      labelStyle: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .inputDecorationTheme
                            .labelStyle
                            ?.color,
                      ),
                      filled: true,
                      fillColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context)
                              .iconTheme
                              .color
                              ?.withValues(alpha: 0.7),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
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
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                      ),
                    ),
                    validator: (value) =>
                        FormValidators.validatePassword(value),
                  ),
                ),
                const SizedBox(height: 20),
                // Confirmer mot de passe
                DelayedAnimation(
                  delay: 1400,
                  curve: Curves.easeOutCubic,
                  slideStartOffset: const Offset(0.0, 0.1),
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirmer le mot de passe',
                      labelStyle: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .inputDecorationTheme
                            .labelStyle
                            ?.color,
                      ),
                      filled: true,
                      fillColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context)
                              .iconTheme
                              .color
                              ?.withValues(alpha: 0.7),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
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
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirmez votre mot de passe';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          // Bouton d'enregistrement
          DelayedAnimation(
            delay: 1500,
            curve: Curves.bounceOut,
            animationDuration: const Duration(milliseconds: 1000),
            child: _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: const Color.fromARGB(225, 249, 29, 88),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 15,
                      ),
                    ),
                    onPressed: _register,
                    child: const Text(
                      'CRÉER UN COMPTE',
                      style: TextStyle(
                        fontFamily: 'Josefin',
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
