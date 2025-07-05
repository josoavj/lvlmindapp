import 'package:flutter/material.dart';
import 'package:lvlmindbeta/pages/homePage.dart';
import 'package:provider/provider.dart';
import 'package:lvlmindbeta/providers/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialise le ThemeNotifier avec le thème du système par défaut
  final themeNotifier = ThemeNotifier(ThemeMode.system);
  // Tente de charger le thème sauvegardé
  await themeNotifier.loadTheme();

  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => themeNotifier, // Fournit l'instance de ThemeNotifier à l'arbre des widgets
      child: const MyApp(), // Votre application principale
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Écoute les changements du thème via Provider
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      title: 'LvlMindBeta',
      debugShowCheckedModeBanner: false,
      // Définition du thème clair
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blueAccent, // Couleur principale pour le thème clair
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white, // Fond des écrans en mode clair
        cardColor: Colors.white, // Fond des cartes en mode clair
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent, // Fond des AppBar en mode clair
          foregroundColor: Colors.white, // Couleur du texte/icônes dans l'AppBar
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
          titleLarge: TextStyle(color: Colors.black87),
          titleMedium: TextStyle(color: Colors.black87),
          titleSmall: TextStyle(color: Colors.black54),
        ).apply(fontFamily: 'Josefin'), // Applique la police Josefin au thème clair
        iconTheme: const IconThemeData(color: Colors.black54), // Couleur des icônes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            shape: const StadiumBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blueAccent,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme( // Thème des champs de saisie
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
        // ... autres personnalisations du thème clair
      ),
      // Définition du thème sombre
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blueAccent, // Conserve une couleur principale
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
        ).apply(fontFamily: 'Josefin'), // Applique la police Josefin au thème sombre
        iconTheme: const IconThemeData(color: Colors.white70),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(225, 249, 29, 88), // Votre couleur rouge pour le bouton CONFIRMER
            foregroundColor: Colors.white,
            shape: const StadiumBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blueAccent, // Conserve la couleur bleue pour les TextButton
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
        // ... autres personnalisations du thème sombre
      ),
      themeMode: themeNotifier.themeMode, // Le mode de thème actuel géré par ThemeNotifier
      home: const Homepage(), // Votre page d'accueil initiale
    );
  }
}