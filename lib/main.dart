import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importez le package provider
import 'package:lvlmindbeta/providers/theme_notifier.dart'; // Importez votre ThemeNotifier
import 'package:lvlmindbeta/screens/welcomepage.dart'; // Votre page d'accueil

// Ces constantes de couleur ne sont plus nécessaires si vous utilisez des thèmes bien définis.
// Vous pouvez les retirer si elles ne sont pas utilisées ailleurs de manière spécifique.
// const d_color = Colors.blueAccent;
// const b_color = Colors.white;

void main() async {
  // Assurez-vous que les bindings Flutter sont initialisés avant d'utiliser des services natifs (comme SharedPreferences).
  WidgetsFlutterBinding.ensureInitialized();

  // Crée une instance de ThemeNotifier et tente de charger le thème sauvegardé.
  // Initialisé avec ThemeMode.system par défaut si rien n'est sauvegardé.
  final themeNotifier = ThemeNotifier(ThemeMode.system);
  await themeNotifier.loadTheme(); // Charge la préférence de thème depuis le stockage local

  runApp(
    // Fournit l'instance de ThemeNotifier à l'arbre des widgets.
    // Cela permet à tous les widgets descendants d'accéder et d'écouter les changements de thème.
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => themeNotifier,
      child: const LvlMindApp(), // Votre application principale
    ),
  );
}

// J'ai renommé 'lvlmind' en 'LvlMindApp' pour suivre les conventions de nommage des classes (PascalCase).
class LvlMindApp extends StatelessWidget {
  const LvlMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Écoute les changements du thème via Provider.
    // Lorsque themeNotifier.notifyListeners() est appelé, ce widget se reconstruit.
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      title: 'LvlMindBeta', // Titre de l'application
      debugShowCheckedModeBanner: false, // Supprime le bandeau "DEBUG"

      // --- Définition du Thème Clair ---
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue, // Couleur primaire générale
        primaryColor: Colors.blueAccent, // Couleur principale du thème clair
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white, // Fond des écrans en mode clair
        cardColor: Colors.white, // Fond des cartes en mode clair
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent, // Fond des AppBar en mode clair
          foregroundColor: Colors.white, // Couleur du texte/icônes dans l'AppBar
          elevation: 0, // Pas d'ombre sous l'AppBar
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
          titleLarge: TextStyle(color: Colors.black87),
          titleMedium: TextStyle(color: Colors.black87),
          titleSmall: TextStyle(color: Colors.black54),
        ).apply(fontFamily: 'Josefin'), // Applique la police Josefin à tous les textes du thème clair
        iconTheme: const IconThemeData(color: Colors.black54), // Couleur des icônes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent, // Couleur de fond par défaut pour les ElevatedButton
            foregroundColor: Colors.white, // Couleur du texte par défaut pour les ElevatedButton
            shape: const StadiumBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blueAccent, // Couleur par défaut pour les TextButton
          ),
        ),
        inputDecorationTheme: InputDecorationTheme( // Thème des champs de saisie pour le mode clair
          filled: true,
          fillColor: Colors.grey[200],
          labelStyle: TextStyle(color: Colors.grey[700]),
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
            borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
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
      ),

      // --- Définition du Thème Sombre ---
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blueAccent, // Conserve une couleur principale similaire
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.grey[900], // Fond des écrans en mode sombre
        cardColor: Colors.grey[850], // Fond des cartes en mode sombre
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900], // Fond des AppBar en mode sombre
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white70),
          bodyMedium: TextStyle(color: Colors.white60),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white70),
          titleSmall: TextStyle(color: Colors.white60),
        ).apply(fontFamily: 'Josefin'), // Applique la police Josefin à tous les textes du thème sombre
        iconTheme: const IconThemeData(color: Colors.white70),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            // La couleur spécifique pour le bouton CONFIRMER dans LoginPage (rouge)
            // est gérée par un style local dans LoginPage pour override ce style global si nécessaire.
            backgroundColor: Colors.blueAccent, // Couleur par défaut pour le mode sombre
            foregroundColor: Colors.white,
            shape: const StadiumBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blueAccent,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme( // Thème des champs de saisie pour le mode sombre
          filled: true,
          fillColor: Colors.grey[700],
          labelStyle: TextStyle(color: Colors.grey[300]),
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
            borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
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
      ),

      // Spécifie quel thème utiliser (clair, sombre, ou système)
      themeMode: themeNotifier.themeMode,

      // La première page de votre application
      home: const WelcomePage(),
    );
  }
}