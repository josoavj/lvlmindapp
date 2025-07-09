import 'package:flutter/material.dart';

class Section {
  final String name; // Le nom de la section (qui servira aussi de filterTag)
  final IconData icon;
  final VoidCallback? onTap; // Callback optionnel pour les actions spécifiques du menu popup

  const Section({required this.name, required this.icon, this.onTap});

  static List<Section> getSections(BuildContext context) {
    return const [
      // Sections qui serviront de filtres
      Section(name: 'TOP', icon: Icons.star),
      Section(name: 'Électronique', icon: Icons.electric_bolt),
      Section(name: 'Intelligence Artificielle', icon: Icons.psychology_alt),
      Section(name: 'Programmation', icon: Icons.code),
      Section(name: 'Design', icon: Icons.brush),
      Section(name: 'Gestion', icon: Icons.business_center),
      Section(name: 'Cybersécurité', icon: Icons.security),
      Section(name: 'Réseaux', icon: Icons.lan),
      Section(name: 'Cloud Computing', icon: Icons.cloud),
      Section(name: 'Big Data', icon: Icons.storage),
      Section(name: 'DevOps', icon: Icons.build),
      Section(name: 'Blockchain', icon: Icons.link),
      Section(name: 'Analyse de Données', icon: Icons.analytics),
      Section(name: 'Génie Logiciel', icon: Icons.precision_manufacturing),
      Section(name: 'Robotique', icon: Icons.android),
      // Ajoutez d'autres sections/filtres si vous avez plus de catégories de matières
    ];
  }
}