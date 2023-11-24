import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Section {
  final IconData icon;
  String name;

  Section({
    required this.icon,
    required this.name,
  });

  static List<Section> getSection() {
    List<Section> secteur = [];
    secteur.add(Section(icon: Iconsax.add_square, name: "Add"));
    secteur.add(Section(icon: Iconsax.pen_add, name: "Modify"));
    return secteur;
  }
}
