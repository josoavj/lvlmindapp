import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lvlmindbeta/providers/theme_notifier.dart';
import 'package:lvlmindbeta/providers/user_notifier.dart';
import 'package:lvlmindbeta/screens/welcome_page.dart';
import 'package:lvlmindbeta/screens/login_page.dart';
import 'package:lvlmindbeta/screens/registration_page.dart';
import 'package:lvlmindbeta/screens/edit_profile_page.dart';
import 'package:lvlmindbeta/screens/profile_page.dart';
import 'package:lvlmindbeta/navigation/app_transition.dart';
import 'package:lvlmindbeta/pages/home_page.dart';
import 'package:lvlmindbeta/services/app_initialization_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser la base de données locale Hive et les services
  await appInit.initialize();

  final themeNotifier = ThemeNotifier(ThemeMode.system);
  await themeNotifier.loadTheme();

  // Charger l'utilisateur actuel
  final userNotifier = UserNotifier();
  await userNotifier.loadCurrentUser();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => themeNotifier,
        ),
        ChangeNotifierProvider<UserNotifier>(
          create: (_) => userNotifier,
        ),
      ],
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

      // --- Définition du Thème Clair (inchangé et correct pour blueAccent) ---
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue, // Utilisé pour générer une palette de bleus
        primaryColor: Colors.blueAccent, // La couleur primaire principale
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors
              .blueAccent, // La couleur à partir de laquelle le ColorScheme est dérivé
          brightness: Brightness.light,
        ).copyWith(
          primary: Colors.blueAccent,
          onPrimary: Colors.white,
          secondary: Colors.pinkAccent,
          onSecondary: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black87,
          error: Colors.red,
          onError: Colors.white,
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
            backgroundColor:
                Colors.blueAccent, // Utilise la couleur primaire du thème
            foregroundColor: Colors.white,
            shape: const StadiumBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor:
                Colors.blueAccent, // Utilise la couleur primaire du thème
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

      // --- Définition du Thème Sombre  ---
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blueAccent, // La couleur primaire principale
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ).copyWith(
          primary: Colors
              .blueAccent, // Assure que la primary de ColorScheme est bien BlueAccent
          onPrimary: Colors.white,
          secondary: Colors.pinkAccent,
          onSecondary: Colors.white,
          surface: const Color(0xFF1E1E1E),
          onSurface: Colors.white70,
          error: Colors.redAccent,
          onError: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.grey[900],
        cardColor: Colors.grey[850],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent[700],
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white70),
        ).apply(fontFamily: 'Josefin'),
        iconTheme: const IconThemeData(color: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            shape: const StadiumBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor:
                Colors.blueAccent, // Conserve le bleu pour les TextButton
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
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/registration': (context) => const RegistrationPage(),
        '/transition': (context) => const Transition(),
        '/home': (context) => const Homepage(),
        '/profile': (context) => const ProfilePage(),
        '/edit_profile': (context) => const EditProfilePage(),
      },
    );
  }
}
