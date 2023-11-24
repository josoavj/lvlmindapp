import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Section {
  static const String add = 'Add';
  static const String modify = 'Modify';
  static const List<String> Choice = <String>[add, modify];

  //icons
  static const Map<String, IconData> ChoiceIcon = <String, IconData>{
    add: Iconsax.add_circle,
    modify: Iconsax.pen_tool,
  };
}
