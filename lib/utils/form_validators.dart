/// Classe contenant les validations réutilisables
class FormValidators {
  FormValidators._(); // Constructeur privé pour empêcher l'instanciation

  /// Valide un numéro de matricule (6 chiffres)
  static String? validateMatricule(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre numéro de matricule';
    }
    if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
      return 'Le matricule doit être un nombre de 6 chiffres';
    }
    return null;
  }

  /// Valide un mot de passe (minimum 8 caractères)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre mot de passe';
    }
    if (value.length < 8) {
      return 'Le mot de passe doit contenir au moins 8 caractères';
    }
    return null;
  }

  /// Valide un email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre email';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Veuillez entrer un email valide';
    }
    return null;
  }

  /// Valide un nom (non vide)
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un nom';
    }
    if (value.length < 2) {
      return 'Le nom doit contenir au moins 2 caractères';
    }
    return null;
  }

  /// Valide un champ non vide
  static String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est obligatoire';
    }
    return null;
  }
}
