import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      // Si aucune préférence n'est enregistrée, nous pouvons vouloir utiliser
      // ThemeMode.system (par défaut) ou ThemeMode.light.
      // Le constructeur reçoit déjà ThemeMode.system de main.dart, donc c'est bon.
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