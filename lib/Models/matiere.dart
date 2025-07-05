import 'package:flutter/material.dart'; // Importation nécessaire pour IconData, si jamais on ajoute des icônes

class Matiere {
  final String name; // Nom de la matière (rendu final)
  final String number; // Par exemple, "3 Chapitres" (rendu final)
  final String image; // Chemin de l'image (rendu final)

  // Constructeur constant pour la classe
  const Matiere({
    required this.name,
    required this.number,
    required this.image,
  });

  // Retourne une liste statique de matières fictives
  static List<Matiere> getFictionalCourses() {
    return const [
      Matiere(name: "Électronique", number: "3 Chapitres", image: 'assets/images/courses/electronic.png'),
      Matiere(name: "Intelligence Artificielle", number: "4 Chapitres", image: 'assets/images/courses/ai.png'),
      Matiere(name: "Structures de Données", number: "6 Chapitres", image: 'assets/images/courses/data_structure.png'),
      Matiere(name: "Algorithmes", number: "8 Chapitres", image: 'assets/images/courses/algorithm.png'),
      Matiere(name: "UI/UX Design", number: "2 Chapitres", image: 'assets/images/courses/ui_ux.png'),
      Matiere(name: "Gestion de Projet", number: "8 Chapitres", image: 'assets/images/courses/project_management.png'),
      Matiere(name: "Développement Web", number: "5 Chapitres", image: 'assets/images/courses/web_dev.png'),
      Matiere(name: "Cybersécurité", number: "7 Chapitres", image: 'assets/images/courses/cybersecurity.png'),
      Matiere(name: "Bases de Données", number: "4 Chapitres", image: 'assets/images/courses/database.png'),
      Matiere(name: "Réseaux Informatiques", number: "6 Chapitres", image: 'assets/images/courses/networking.png'),
      Matiere(name: "Développement Mobile", number: "5 Chapitres", image: 'assets/images/courses/mobile_dev.png'),
    ];
  }
}

class Secteur {
  final String name; // Nom du secteur (rendu final)
  final String image; // Chemin de l'image (rendu final)

  // Constructeur constant pour la classe
  const Secteur({
    required this.name,
    required this.image,
  });

  // Retourne une liste statique de secteurs fictifs
  static List<Secteur> getFictionalSectors() {
    return const [
      Secteur(name: "Hacking Éthique", image: 'assets/images/sectors/hacking.png'),
      Secteur(name: "Développement Web", image: 'assets/images/sectors/web_dev.png'),
      Secteur(name: "Réseautage", image: 'assets/images/sectors/networking.png'),
      Secteur(name: "Trading & Finance", image: 'assets/images/sectors/trading.png'),
      Secteur(name: "Design Graphique", image: 'assets/images/sectors/design.png'),
      Secteur(name: "Art Digital", image: 'assets/images/sectors/digital_art.png'),
      Secteur(name: "Peinture Traditionnelle", image: 'assets/images/sectors/painting.png'),
      Secteur(name: "Astrologie", image: 'assets/images/sectors/astrology.png'),
      Secteur(name: "Intelligence Artificielle", image: 'assets/images/sectors/ai_sector.png'),
      Secteur(name: "Développement Mobile", image: 'assets/images/sectors/mobile_sector.png'),
      Secteur(name: "DevOps", image: 'assets/images/sectors/devops.png'),
      Secteur(name: "Biotechnologie", image: 'assets/images/sectors/biotech.png'),
      Secteur(name: "Marketing Digital", image: 'assets/images/sectors/digital_marketing.png'),
      Secteur(name: "Robotique", image: 'assets/images/sectors/robotics.png'),
      Secteur(name: "Science des Données", image: 'assets/images/sectors/data_science.png'),
    ];
  }
}