import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lvlmindbeta/providers/theme_notifier.dart';
import 'package:lvlmindbeta/screens/welcomepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeNotifier = ThemeNotifier(ThemeMode.system);
  await themeNotifier.loadTheme();

  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => themeNotifier,
      child: const LvlMindApp(),
    ),
  );
}

class LvlMindApp extends StatelessWidget {
  const LvlMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      title: 'LvlMindBeta',
      debugShowCheckedModeBanner: false,

      // --- Définition du Thème Clair (inchangé) ---
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blueAccent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
          titleLarge: TextStyle(color: Colors.black87),
          titleMedium: TextStyle(color: Colors.black87),
          titleSmall: TextStyle(color: Colors.black54),
        ).apply(fontFamily: 'Josefin'),
        iconTheme: const IconThemeData(color: Colors.black54),
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
        inputDecorationTheme: InputDecorationTheme(
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

      // --- Définition du Thème Sombre (modifié pour une meilleure visibilité des textes) ---
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blueAccent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.grey[900],
        cardColor: Colors.grey[850],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          foregroundColor: Colors.white, // Toujours blanc pour les icônes/texte d'AppBar
          elevation: 0,
        ),
        textTheme: const TextTheme(
          // Rendu plus clair pour une meilleure visibilité en mode sombre
          bodyLarge: TextStyle(color: Colors.white), // Plus lumineux
          bodyMedium: TextStyle(color: Colors.white70), // Légèrement moins lumineux
          titleLarge: TextStyle(color: Colors.white), // Blanc pur pour les titres importants
          titleMedium: TextStyle(color: Colors.white), // Blanc pur
          titleSmall: TextStyle(color: Colors.white70), // Légèrement moins lumineux
        ).apply(fontFamily: 'Josefin'),
        iconTheme: const IconThemeData(color: Colors.white), // Icônes blanches
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(225, 249, 29, 88),
            foregroundColor: Colors.white,
            shape: const StadiumBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blueAccent, // Conserve le bleu pour les TextButton
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
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

      themeMode: themeNotifier.themeMode,
      home: const WelcomePage(),
    );
  }
}