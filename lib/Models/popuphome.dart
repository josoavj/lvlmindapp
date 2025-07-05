import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Section {
  final IconData icon;
  final String name; // Changed to final as 'name' usually doesn't change after creation.
  final VoidCallback? onTap; // Added an optional callback for when the section is tapped.

  const Section({
    required this.icon,
    required this.name,
    this.onTap, // Made onTap optional
  });

  // Provides a static list of predefined sections.
  // This can be easily extended or modified.
  static List<Section> getSections() {
    return [
      Section(
        icon: Iconsax.add_square,
        name: "Ajouter", // Translated to French for consistency
        onTap: () {
          // TODO: Implement 'Add' functionality
          debugPrint("Add section tapped!");
        },
      ),
      Section(
        icon: Iconsax.pen_add, // Iconsax.edit for more general 'edit'
        name: "Modifier", // Translated to French
        onTap: () {
          // TODO: Implement 'Modify' functionality
          debugPrint("Modify section tapped!");
        },
      ),
    ];
  }
}