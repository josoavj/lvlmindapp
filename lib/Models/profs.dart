import 'package:flutter/material.dart';

class Profs {
  final String pname; // Nom du professeur (rendu final pour l'immutabilité)
  final String iconpath; // Chemin de l'image du professeur (rendu final)
  final String? bio; // Ajout d'un champ optionnel pour une courte biographie ou spécialité
  final String? email; // Ajout d'un champ optionnel pour l'email de contact

  // Constructeur constant pour la classe
  const Profs({
    required this.pname,
    required this.iconpath,
    this.bio, // Bio est optionnel
    this.email, // Email est optionnel
  });

  // Méthode statique pour obtenir une liste de professeurs fictifs
  static List<Profs> getFictionalProfs() {
    return const [
      Profs(
        pname: "M. Andry",
        iconpath: 'assets/images/profs/prof3.png', // Ton chemin d'image
        bio: "Spécialiste en Systèmes Embarqués",
        email: "andry.r@example.com",
      ),
      Profs(
        pname: "M. Tsoa",
        iconpath: 'assets/images/profs/prof3.png', // Ton chemin d'image
        bio: "Expert en Intelligence Artificielle et Machine Learning",
        email: "tsoa.n@example.com",
      ),
      Profs(
        pname: "Pr. Julien",
        iconpath: 'assets/images/profs/prof1.jpg', // Ton chemin d'image
        bio: "Professeur de Théorie des Graphes et Algorithmes",
        email: "julien.k@example.com",
      ),
      Profs(
        pname: "Mme Maeva",
        iconpath: 'assets/images/profs/prof2.jpg', // Ton chemin d'image
        bio: "Chercheuse en Cybersécurité et Réseaux",
        email: "maeva.d@example.com",
      ),
      Profs(
        pname: "M. Toky",
        iconpath: 'assets/images/profs/prof3.png', // Ton chemin d'image
        bio: "Développeur Senior en Applications Mobiles (Flutter)",
        email: "toky.l@example.com",
      ),
      Profs(
        pname: "M. Michel",
        iconpath: 'assets/images/profs/prof4.png', // Ton chemin d'image
        bio: "Architecte Logiciel et Expert DevOps",
        email: "michel.b@example.com",
      ),
      // Ajout de quelques professeurs supplémentaires pour enrichir la liste,
      // utilisant tes chemins d'images si tu en as d'autres, sinon des génériques.
      Profs(
        pname: "Mme Sophie",
        iconpath: 'assets/images/profs/prof2.jpg', // Réutilisation de ton chemin
        bio: "Spécialiste en Bases de Données et Big Data",
        email: "sophie.p@example.com",
      ),
      Profs(
        pname: "Pr. Romain",
        iconpath: 'assets/images/profs/prof1.jpg', // Réutilisation de ton chemin
        bio: "Professeur de Cryptographie",
        email: "romain.g@example.com",
      ),
    ];
  }
}