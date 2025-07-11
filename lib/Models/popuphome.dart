import 'package:flutter/material.dart';

class Section {
  String name; // Le nom de la section
  int iconCodePoint; // Code point de l'icône pour la persistance
  String iconFontFamily; // Famille de la police de l'icône
  VoidCallback? onTap; // Callback optionnel (non persistant)

  Section({
    required this.name,
    required this.iconCodePoint,
    required this.iconFontFamily,
    this.onTap,
  });

  // Constructeur pour créer une Section à partir d'un IconData
  factory Section.fromIconData({
    required String name,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return Section(
      name: name,
      iconCodePoint: icon.codePoint,
      iconFontFamily: icon.fontFamily!, // Assurez-vous que fontFamily n'est pas nul
      onTap: onTap,
    );
  }

  // Convertit une Section en Map pour la sérialisation JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'iconCodePoint': iconCodePoint,
      'iconFontFamily': iconFontFamily,
    };
  }

  // Crée une Section à partir d'une Map (désérialisation JSON)
  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      name: json['name'],
      iconCodePoint: json['iconCodePoint'],
      iconFontFamily: json['iconFontFamily'],
      // onTap n'est pas inclus dans la persistance, il doit être recréé si nécessaire
    );
  }

  // Méthode pour obtenir l'IconData à partir des propriétés stockées
  IconData get icon => IconData(iconCodePoint, fontFamily: iconFontFamily);

  // Liste des icônes disponibles pour le dialogue d'ajout
  static List<IconData> get availableIcons => [
    Icons.star,
    Icons.electric_bolt,
    Icons.psychology_alt,
    Icons.code,
    Icons.brush,
    Icons.business_center,
    Icons.security,
    Icons.lan,
    Icons.cloud,
    Icons.storage,
    Icons.build,
    Icons.link,
    Icons.analytics,
    Icons.precision_manufacturing,
    Icons.android,
    Icons.laptop,
    Icons.mobile_friendly,
    Icons.palette,
    Icons.lightbulb,
    Icons.data_usage,
    Icons.supervised_user_circle,
    Icons.sports_esports,
    Icons.eco,
    Icons.monetization_on,
    Icons.school,
    Icons.rocket_launch,
    Icons.science,
    Icons.medical_services,
    Icons.map,
    Icons.camera_alt,
    Icons.music_note,
    Icons.fastfood,
    Icons.fitness_center,
    Icons.home,
    Icons.work,
    Icons.travel_explore,
    Icons.shopping_cart,
    Icons.book,
    Icons.favorite,
    Icons.thumb_up,
    Icons.settings,
    Icons.notifications,
    Icons.message,
    Icons.person,
    Icons.group,
    Icons.event,
    Icons.location_on,
    Icons.camera,
    Icons.mic,
    Icons.alarm,
    Icons.calendar_today,
    Icons.folder,
    Icons.description,
    Icons.attach_file,
    Icons.image,
    Icons.video_camera_back,
    Icons.headphones,
    Icons.wifi,
    Icons.bluetooth,
    Icons.battery_full,
    Icons.flash_on,
    Icons.brightness_high,
    Icons.volume_up,
    Icons.volume_off,
    Icons.call,
    Icons.mail,
    Icons.chat,
    Icons.send,
    Icons.delete,
    Icons.edit,
    Icons.add,
    Icons.remove,
    Icons.check,
    Icons.close,
    Icons.search,
    Icons.info,
    Icons.help,
    Icons.warning,
    Icons.error,
    Icons.done,
    Icons.cancel,
    Icons.refresh,
    Icons.upload_file,
    Icons.download,
    Icons.share,
    Icons.print,
    Icons.save,
    Icons.star_border,
    Icons.favorite_border,
    Icons.bookmark,
    Icons.bookmark_border,
    Icons.visibility,
    Icons.visibility_off,
    Icons.lock,
    Icons.lock_open,
    Icons.vpn_key,
    Icons.fingerprint,
    Icons.face,
    Icons.sentiment_satisfied,
    Icons.sentiment_dissatisfied,
  ];
}