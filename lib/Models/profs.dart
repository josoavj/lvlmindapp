import 'package:flutter/material.dart';

class Profs {
  final String pname; // Nom du professeur (renommé de profname pour correspondre à ton code)
  final String iconpath; // Chemin de l'image du professeur (renommé de profpic)
  final String? bio; // Champ optionnel pour une courte biographie ou spécialité
  final String? email; // Champ optionnel pour l'email de contact
  final String profeducation; // Ajouté: niveau d'éducation/diplôme
  final String phone; // Ajouté: numéro de téléphone
  final List<String> courses; // Ajouté: liste des cours enseignés

  // Constructeur constant pour la classe Profs
  const Profs({
    required this.pname,
    required this.iconpath,
    required this.profeducation, // Rendu requis
    required this.phone,         // Rendu requis
    required this.email,         // Rendu requis
    required this.courses,       // Rendu requis
    this.bio, // Bio reste optionnel, mais je recommande de le rendre requis pour les détails de prof
  });

  // Méthode statique pour obtenir une liste de professeurs fictifs
  static List<Profs> getFictionalProfs() {
    return const [
      Profs(
        pname: "M. Andry",
        iconpath: 'assets/images/profs/prof3.png',
        profeducation: "PhD en Systèmes Embarqués, Université d'Antananarivo",
        bio: "Spécialiste en conception et optimisation de systèmes embarqués, avec une expérience approfondie dans l'IoT.",
        phone: "+261 32 11 223 34",
        email: "andry.r@lvlmind.com",
        courses: ["Systèmes Embarqués Avancés", "Programmation Microcontrôleurs", "IoT et Capteurs"],
      ),
      Profs(
        pname: "M. Tsoa",
        iconpath: 'assets/images/profs/prof3.png',
        profeducation: "Master en Intelligence Artificielle, École Supérieure Polytechnique",
        bio: "Expert en Intelligence Artificielle et Machine Learning, avec une passion pour les applications pratiques de l'IA.",
        phone: "+261 34 22 334 45",
        email: "tsoa.n@lvlmind.com",
        courses: ["Introduction à l'IA", "Apprentissage Supervisé", "Réseaux de Neurones Profonds"],
      ),
      Profs(
        pname: "Pr. Julien",
        iconpath: 'assets/images/profs/prof1.jpg',
        profeducation: "Doctorat en Mathématiques Appliquées, Université de Paris-Saclay",
        bio: "Professeur émérite de Théorie des Graphes et Algorithmes, réputé pour sa pédagogie claire et ses recherches innovantes.",
        phone: "+261 33 55 667 78",
        email: "julien.k@lvlmind.com",
        courses: ["Théorie des Graphes", "Algorithmique Avancée", "Optimisation Combinatoire"],
      ),
      Profs(
        pname: "Mme Maeva",
        iconpath: 'assets/images/profs/prof2.jpg',
        profeducation: "Ingénieur en Cybersécurité, ESIEA",
        bio: "Chercheuse en Cybersécurité et Réseaux, spécialisée dans la sécurité des infrastructures critiques et les tests d'intrusion.",
        phone: "+261 32 66 778 89",
        email: "maeva.d@lvlmind.com",
        courses: ["Sécurité Informatique Fondamentale", "Sécurité des Réseaux", "Pentesting et Vulnérabilités"],
      ),
      Profs(
        pname: "M. Toky",
        iconpath: 'assets/images/profs/prof3.png',
        profeducation: "Master en Développement d'Applications Mobiles, Université Virtuelle Africaine",
        bio: "Développeur Senior en Applications Mobiles (Flutter), avec une expertise reconnue dans la création d'interfaces utilisateur fluides et réactives.",
        phone: "+261 34 77 889 90",
        email: "toky.l@lvlmind.com",
        courses: ["Développement Flutter Avancé", "UI/UX Mobile", "Gestion de l'État Flutter"],
      ),
      Profs(
        pname: "M. Michel",
        iconpath: 'assets/images/profs/prof4.png',
        profeducation: "Architecte Logiciel Certifié, Google Cloud",
        bio: "Architecte Logiciel et Expert DevOps, passionné par l'automatisation des déploiements et la scalabilité des systèmes.",
        phone: "+261 33 11 223 33",
        email: "michel.b@lvlmind.com",
        courses: ["Architecture Logicielle", "Principes DevOps", "Intégration et Déploiement Continus"],
      ),
      Profs(
        pname: "Mme Sophie",
        iconpath: 'assets/images/profs/prof2.jpg',
        profeducation: "Master en Science des Données, Université Pierre et Marie Curie",
        bio: "Spécialiste en Bases de Données et Big Data, avec une solide expérience dans l'analyse de données et la modélisation prédictive.",
        phone: "+261 32 99 887 76",
        email: "sophie.p@lvlmind.com",
        courses: ["Bases de Données Relationnelles", "NoSQL et Big Data", "Analyse de Données avec Python"],
      ),
      Profs(
        pname: "Pr. Romain",
        iconpath: 'assets/images/profs/prof1.jpg',
        profeducation: "Doctorat en Cryptographie, École Normale Supérieure",
        bio: "Professeur de Cryptographie et Sécurité de l'Information, ses recherches se concentrent sur les protocoles de chiffrement post-quantiques.",
        phone: "+261 34 00 112 23",
        email: "romain.g@lvlmind.com",
        courses: ["Fondamentaux de la Cryptographie", "Sécurité des Systèmes d'Information", "Blockchain et Cryptomonnaies"],
      ),
    ];
  }
}