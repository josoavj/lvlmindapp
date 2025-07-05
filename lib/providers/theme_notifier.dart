import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Pour sauvegarder la préférence de l'utilisateur

/// Un ChangeNotifier pour gérer l'état du thème de l'application (clair/sombre).
class ThemeNotifier with ChangeNotifier {
  ThemeMode _themeMode; // L'état actuel du thème

  // Clé pour SharedPreferences
  static const String _themeModeKey = 'themeMode';

  ThemeNotifier(this._themeMode); // Constructeur pour initialiser avec un mode de thème

  ThemeMode get themeMode => _themeMode; // Getter pour accéder au mode de thème actuel

  /// Initialise le ThemeNotifier en chargeant la préférence de thème depuis SharedPreferences.
  /// Si aucune préférence n'est trouvée, utilise le thème du système par défaut.
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final int? storedThemeIndex = prefs.getInt(_themeModeKey);

    if (storedThemeIndex != null) {
      _themeMode = ThemeMode.values[storedThemeIndex];
    } else {
      // Si aucune préférence n'est enregistrée, nous pourrions vouloir utiliser
      // ThemeMode.system ou un défaut comme ThemeMode.light.
      // Pour cet exemple, nous allons rester sur la valeur passée au constructeur
      // (qui sera ThemeMode.system depuis main.dart).
    }
    notifyListeners(); // Notifie les auditeurs que le thème a été chargé
  }

  /// Bascule le thème entre clair et sombre, et sauvegarde la préférence.
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _saveTheme(_themeMode.index); // Sauvegarde l'index du thème
    notifyListeners(); // Notifie tous les widgets qui écoutent ce notifier
  }

  /// Définit explicitement le thème et sauvegarde la préférence.
  void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      _saveTheme(_themeMode.index);
      notifyListeners();
    }
  }

  /// Sauvegarde la préférence de thème dans SharedPreferences.
  Future<void> _saveTheme(int themeIndex) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, themeIndex);
  }
}