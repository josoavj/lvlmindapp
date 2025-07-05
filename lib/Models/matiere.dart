import 'package:flutter/material.dart'; // Importation nécessaire pour IconData, si jamais on ajoute des icônes

class Matiere {
  final String name; // Nom de la matière
  final String number; // Par exemple, "10 Chapitres"
  final String image; // Chemin de l'image
  final List<String> chapters; // Liste des noms de chapitres

  // Constructeur constant pour la classe
  const Matiere({
    required this.name,
    required this.number,
    required this.image,
    required this.chapters, // Le champ chapters est maintenant requis
  });

  // Retourne une liste statique de matières fictives avec 10 chapitres chacune
  static List<Matiere> getFictionalCourses() {
    return const [
      Matiere(
        name: "Électronique",
        number: "10 Chapitres",
        image: 'assets/images/courses/electronic.png',
        chapters: [
          "Chapitre 1: Fondamentaux de l'Électricité",
          "Chapitre 2: Composants Passifs (Résistances, Condensateurs, Inductances)",
          "Chapitre 3: Lois de Kirchhoff et Théorèmes de Base",
          "Chapitre 4: Diodes et Applications",
          "Chapitre 5: Transistors Bipolaires et FET",
          "Chapitre 6: Amplificateurs Opérationnels (AOP)",
          "Chapitre 7: Circuits Logiques Numériques",
          "Chapitre 8: Capteurs et Actionneurs",
          "Chapitre 9: Conversion Analogique-Numérique (CAN/CNA)",
          "Chapitre 10: Systèmes Embarqués et Microcontrôleurs",
        ],
      ),
      Matiere(
        name: "Intelligence Artificielle",
        number: "10 Chapitres",
        image: 'assets/images/courses/ai.png',
        chapters: [
          "Chapitre 1: Introduction à l'IA et son Histoire",
          "Chapitre 2: Résolution de Problèmes et Recherche Heuristique",
          "Chapitre 3: Représentation des Connaissances et Raisonnement",
          "Chapitre 4: Apprentissage Automatique (Machine Learning) - Concepts de Base",
          "Chapitre 5: Apprentissage Supervisé",
          "Chapitre 6: Apprentissage Non Supervisé et Réduction de Dimensionalité",
          "Chapitre 7: Apprentissage Profond (Deep Learning) - Réseaux de Neurones",
          "Chapitre 8: Traitement du Langage Naturel (TLN)",
          "Chapitre 9: Vision par Ordinateur",
          "Chapitre 10: Éthique de l'IA et Enjeux Sociétaux",
        ],
      ),
      Matiere(
        name: "Structures de Données",
        number: "10 Chapitres",
        image: 'assets/images/courses/data_structure.png',
        chapters: [
          "Chapitre 1: Introduction aux Structures de Données",
          "Chapitre 2: Tableaux et Listes Liées",
          "Chapitre 3: Piles et Files",
          "Chapitre 4: Arbres Binaires et Arbres de Recherche Binaire",
          "Chapitre 5: Arbres Équilibrés (AVL, Rouge-Noir)",
          "Chapitre 6: Heaps et Files de Priorité",
          "Chapitre 7: Tables de Hachage",
          "Chapitre 8: Graphes - Représentation et Parcours",
          "Chapitre 9: Algorithmes sur les Graphes (Chemin le plus court, arbres couvrants)",
          "Chapitre 10: Structures de Données Avancées et Disques",
        ],
      ),
      Matiere(
        name: "Algorithmes",
        number: "10 Chapitres",
        image: 'assets/images/courses/algorithm.png',
        chapters: [
          "Chapitre 1: Introduction à l'Analyse d'Algorithmes",
          "Chapitre 2: Algorithmes de Tri (Sélection, Insertion, Bulle)",
          "Chapitre 3: Algorithmes de Tri Avancés (Fusion, Rapide, Tas)",
          "Chapitre 4: Algorithmes de Recherche (Séquentielle, Binaire)",
          "Chapitre 5: Programmation Dynamique",
          "Chapitre 6: Algorithmes Gloutons",
          "Chapitre 7: Backtracking et Branch and Bound",
          "Chapitre 8: Diviser pour Régner",
          "Chapitre 9: Algorithmes sur les Chaînes de Caractères",
          "Chapitre 10: Complexité des Algorithmes et Classes P/NP",
        ],
      ),
      Matiere(
        name: "UI/UX Design",
        number: "10 Chapitres",
        image: 'assets/images/courses/ui_ux.png',
        chapters: [
          "Chapitre 1: Fondamentaux de l'UI/UX",
          "Chapitre 2: Recherche Utilisateur et Personas",
          "Chapitre 3: Wireframing et Prototypage",
          "Chapitre 4: Principes d'Usabilité et Accessibilité",
          "Chapitre 5: Théorie des Couleurs et Typographie",
          "Chapitre 6: Conception Responsive et Adaptative",
          "Chapitre 7: Design System et Composants",
          "Chapitre 8: Tests Utilisateurs et Itérations",
          "Chapitre 9: Outils de Design (Figma, Sketch, Adobe XD)",
          "Chapitre 10: Portfolio UI/UX et Carrière",
        ],
      ),
      Matiere(
        name: "Gestion de Projet",
        number: "10 Chapitres",
        image: 'assets/images/courses/project_management.png',
        chapters: [
          "Chapitre 1: Introduction à la Gestion de Projet",
          "Chapitre 2: Cycle de Vie d'un Projet",
          "Chapitre 3: Planification et Établissement des Objectifs",
          "Chapitre 4: Gestion des Parties Prenantes et Communication",
          "Chapitre 5: Gestion des Risques",
          "Chapitre 6: Gestion des Ressources et du Budget",
          "Chapitre 7: Méthodologies Agiles (Scrum, Kanban)",
          "Chapitre 8: Suivi et Contrôle du Projet",
          "Chapitre 9: Clôture du Projet et Leçons Apprises",
          "Chapitre 10: Leadership et Équipes de Projet",
        ],
      ),
      Matiere(
        name: "Développement Web",
        number: "10 Chapitres",
        image: 'assets/images/courses/web_dev.png',
        chapters: [
          "Chapitre 1: Fondamentaux du Web (HTML, CSS)",
          "Chapitre 2: JavaScript Basique",
          "Chapitre 3: Introduction au Frontend (Frameworks CSS comme Bootstrap)",
          "Chapitre 4: JavaScript Avancé (DOM, Événements, Requêtes Asynchrones)",
          "Chapitre 5: Frameworks Frontend (React, Angular, Vue.js)",
          "Chapitre 6: Introduction au Backend (Node.js, Python/Django, PHP/Laravel)",
          "Chapitre 7: Bases de Données pour le Web (SQL, NoSQL)",
          "Chapitre 8: API RESTful",
          "Chapitre 9: Sécurité Web",
          "Chapitre 10: Déploiement et Maintenance",
        ],
      ),
      Matiere(
        name: "Cybersécurité",
        number: "10 Chapitres",
        image: 'assets/images/courses/cybersecurity.png',
        chapters: [
          "Chapitre 1: Introduction à la Cybersécurité",
          "Chapitre 2: Menaces et Vulnérabilités Courantes",
          "Chapitre 3: Cryptographie Fondamentale",
          "Chapitre 4: Sécurité des Réseaux",
          "Chapitre 5: Sécurité des Systèmes d'Exploitation",
          "Chapitre 6: Sécurité Applicative (Web et Mobile)",
          "Chapitre 7: Hacking Éthique et Tests d'Intrusion",
          "Chapitre 8: Gestion des Incidents de Sécurité",
          "Chapitre 9: Lois et Régulations en Cybersécurité",
          "Chapitre 10: Carrières en Cybersécurité",
        ],
      ),
      Matiere(
        name: "Bases de Données",
        number: "10 Chapitres",
        image: 'assets/images/courses/database.png',
        chapters: [
          "Chapitre 1: Concepts Fondamentaux des Bases de Données",
          "Chapitre 2: Modèle Entité-Relation (MER)",
          "Chapitre 3: Modèle Relationnel et Normalisation",
          "Chapitre 4: SQL - Requêtes de Base (SELECT, INSERT, UPDATE, DELETE)",
          "Chapitre 5: SQL - Jointures et Sous-requêtes",
          "Chapitre 6: Transactions et Contrôle de Concurrence",
          "Chapitre 7: Indexation et Optimisation des Requêtes",
          "Chapitre 8: Bases de Données NoSQL (Types et Cas d'Usage)",
          "Chapitre 9: Administration de Bases de Données (Sauvegarde, Restauration)",
          "Chapitre 10: Sécurité des Bases de Données",
        ],
      ),
      Matiere(
        name: "Réseaux Informatiques",
        number: "10 Chapitres",
        image: 'assets/images/courses/networking.png',
        chapters: [
          "Chapitre 1: Introduction aux Réseaux",
          "Chapitre 2: Modèle OSI et TCP/IP",
          "Chapitre 3: Couche Physique et Liaison de Données (Ethernet, Wi-Fi)",
          "Chapitre 4: Couche Réseau (Adresses IP, Routage)",
          "Chapitre 5: Couche Transport (TCP, UDP)",
          "Chapitre 6: Couche Application (HTTP, DNS, FTP)",
          "Chapitre 7: Équipements Réseau (Routeurs, Commutateurs)",
          "Chapitre 8: Sécurité des Réseaux (Firewalls, VPN)",
          "Chapitre 9: Technologies Sans Fil",
          "Chapitre 10: Administration et Dépannage Réseau",
        ],
      ),
      Matiere(
        name: "Développement Mobile",
        number: "10 Chapitres",
        image: 'assets/images/courses/mobile_dev.png',
        chapters: [
          "Chapitre 1: Introduction au Développement Mobile",
          "Chapitre 2: Environnements de Développement (Android Studio, Xcode, VS Code)",
          "Chapitre 3: Principes de Conception d'Applications Mobiles",
          "Chapitre 4: UI/UX pour Mobile",
          "Chapitre 5: Gestion de l'État dans les Applications Mobiles",
          "Chapitre 6: Persistance des Données (SQLite, Firebase)",
          "Chapitre 7: Intégration d'API et Services Web",
          "Chapitre 8: Notifications Push et Services en Arrière-plan",
          "Chapitre 9: Tests et Débogage d'Applications Mobiles",
          "Chapitre 10: Déploiement sur App Stores (Google Play, Apple App Store)",
        ],
      ),
      // --- NOUVELLES MATIERES AJOUTÉES (Réutilisant les images existantes) ---
      Matiere(
        name: "Programmation Orientée Objet",
        number: "10 Chapitres",
        image: 'assets/images/courses/data_structure.png', // Réutilisation d'une image existante
        chapters: [
          "Chapitre 1: Concepts Fondamentaux de l'POO",
          "Chapitre 2: Classes et Objets",
          "Chapitre 3: Encapsulation et Visibilité",
          "Chapitre 4: Héritage et Polymorphisme",
          "Chapitre 5: Interfaces et Classes Abstraites",
          "Chapitre 6: Gestion des Exceptions",
          "Chapitre 7: Principes SOLID",
          "Chapitre 8: Design Patterns de Base",
          "Chapitre 9: UML pour la Conception POO",
          "Chapitre 10: POO dans les Langages Modernes (Java, C++, Python)",
        ],
      ),
      Matiere(
        name: "Cloud Computing",
        number: "10 Chapitres",
        image: 'assets/images/courses/networking.png', // Réutilisation d'une image existante
        chapters: [
          "Chapitre 1: Introduction au Cloud Computing",
          "Chapitre 2: Modèles de Service (IaaS, PaaS, SaaS)",
          "Chapitre 3: Modèles de Déploiement (Public, Privé, Hybride)",
          "Chapitre 4: Virtualisation et Conteneurisation (Docker, Kubernetes)",
          "Chapitre 5: Services AWS de Base (EC2, S3, RDS)",
          "Chapitre 6: Services Azure de Base (VMs, Storage, Azure SQL)",
          "Chapitre 7: Google Cloud Platform (Compute Engine, Cloud Storage)",
          "Chapitre 8: Sécurité dans le Cloud",
          "Chapitre 9: Gestion des Coûts et Optimisation",
          "Chapitre 10: Serverless Computing (Fonctions Lambda, Azure Functions)",
        ],
      ),
      Matiere(
        name: "Big Data",
        number: "10 Chapitres",
        image: 'assets/images/courses/database.png', // Réutilisation d'une image existante
        chapters: [
          "Chapitre 1: Introduction au Big Data",
          "Chapitre 2: Les 3 V du Big Data (Volume, Vélocité, Variété)",
          "Chapitre 3: Architectures Big Data (Hadoop, Spark)",
          "Chapitre 4: Stockage Distribué (HDFS)",
          "Chapitre 5: Traitement Distribué (MapReduce, Spark Core)",
          "Chapitre 6: Bases de Données NoSQL pour le Big Data",
          "Chapitre 7: Streaming de Données (Kafka, Flink)",
          "Chapitre 8: Outils d'Analyse Big Data (Hive, Pig)",
          "Chapitre 9: Pipelines de Données et ETL",
          "Chapitre 10: Cas d'Usage et Applications du Big Data",
        ],
      ),
      Matiere(
        name: "DevOps",
        number: "10 Chapitres",
        image: 'assets/images/courses/project_management.png', // Réutilisation d'une image existante
        chapters: [
          "Chapitre 1: Introduction au DevOps et ses Principes",
          "Chapitre 2: Intégration Continue (CI)",
          "Chapitre 3: Livraison Continue (CD)",
          "Chapitre 4: Outils de Gestion de Version (Git)",
          "Chapitre 5: Automatisation de l'Infrastructure (Infrastructure as Code)",
          "Chapitre 6: Conteneurisation (Docker)",
          "Chapitre 7: Orchestration de Conteneurs (Kubernetes)",
          "Chapitre 8: Monitoring et Logging",
          "Chapitre 9: Sécurité dans le Pipeline DevOps (DevSecOps)",
          "Chapitre 10: Culture DevOps et Collaboration",
        ],
      ),
      Matiere(
        name: "Blockchain",
        number: "10 Chapitres",
        image: 'assets/images/courses/electronic.png', // Réutilisation d'une image existante
        chapters: [
          "Chapitre 1: Introduction à la Blockchain",
          "Chapitre 2: Cryptographie et Hachage",
          "Chapitre 3: Blocs et Chaîne de Blocs",
          "Chapitre 4: Consensus et Preuve de Travail (PoW)",
          "Chapitre 5: Ethereum et Contrats Intelligents",
          "Chapitre 6: Applications Décentralisées (DApps)",
          "Chapitre 7: Types de Blockchains (Publiques, Privées, de Consortium)",
          "Chapitre 8: Cas d'Usage de la Blockchain (Finance, Supply Chain)",
          "Chapitre 9: Défis et Régulation de la Blockchain",
          "Chapitre 10: Développer avec des Frameworks Blockchain",
        ],
      ),
      Matiere(
        name: "Analyse de Données",
        number: "10 Chapitres",
        image: 'assets/images/courses/ai.png', // Réutilisation d'une image existante
        chapters: [
          "Chapitre 1: Introduction à l'Analyse de Données",
          "Chapitre 2: Collecte et Nettoyage des Données",
          "Chapitre 3: Statistiques Descriptives",
          "Chapitre 4: Visualisation des Données",
          "Chapitre 5: Introduction aux Bases de Données (SQL)",
          "Chapitre 6: Outils d'Analyse (Excel, Python/Pandas, R)",
          "Chapitre 7: Analyse Exploratoire des Données (EDA)",
          "Chapitre 8: Tests d'Hypothèses et Inférence",
          "Chapitre 9: Modélisation Prédictive Simple",
          "Chapitre 10: Rapports et Présentation des Résultats",
        ],
      ),
      Matiere(
        name: "Génie Logiciel",
        number: "10 Chapitres",
        image: 'assets/images/courses/web_dev.png', // Réutilisation d'une image existante
        chapters: [
          "Chapitre 1: Introduction au Génie Logiciel",
          "Chapitre 2: Modèles de Processus Logiciels (Cascade, Agile)",
          "Chapitre 3: Exigences Logiciels",
          "Chapitre 4: Conception Logicielle (UML)",
          "Chapitre 5: Implémentation et Codage",
          "Chapitre 6: Tests Logiciels (Unitaires, Intégration, Système)",
          "Chapitre 7: Gestion de Configuration Logicielle",
          "Chapitre 8: Assurance Qualité Logicielle",
          "Chapitre 9: Maintenance et Évolution du Logiciel",
          "Chapitre 10: Éthique et Responsabilité Professionnelle",
        ],
      ),
      Matiere(
        name: "Robotique",
        number: "10 Chapitres",
        image: 'assets/images/courses/algorithm.png', // Réutilisation d'une image existante
        chapters: [
          "Chapitre 1: Introduction à la Robotique",
          "Chapitre 2: Composants d'un Robot (Capteurs, Actionneurs)",
          "Chapitre 3: Cinématique des Robots",
          "Chapitre 4: Planification de Trajectoire",
          "Chapitre 5: Contrôle Moteur et Servomécanismes",
          "Chapitre 6: Programmation de Robots (ROS, Python)",
          "Chapitre 7: Vision par Ordinateur pour la Robotique",
          "Chapitre 8: Intelligence Artificielle en Robotique",
          "Chapitre 9: Robotique Mobile et Navigation",
          "Chapitre 10: Applications Industrielles et Humanoïdes",
        ],
      ),
    ];
  }
}

class Secteur {
  final String name; // Nom du secteur
  final String image; // Chemin de l'image

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
      Secteur(name: "Réalité Virtuelle (VR)", image: 'assets/images/sectors/hacking.png'),
      Secteur(name: "Cybersécurité Avancée", image: 'assets/images/sectors/cybersecurity.png'),
      Secteur(name: "Gestion des Produits", image: 'assets/images/sectors/project_management.png'),
      Secteur(name: "Biomédical", image: 'assets/images/sectors/biotech.png'),
      Secteur(name: "Écologie et Environnement", image: 'assets/images/sectors/digital_art.png'),
      Secteur(name: "Finance Durable", image: 'assets/images/sectors/trading.png'),
      Secteur(name: "Éducation en Ligne", image: 'assets/images/sectors/design.png'),
      Secteur(name: "Jeux Vidéo", image: 'assets/images/sectors/gaming.png'),
      Secteur(name: "Modélisation 3D", image: 'assets/images/sectors/digital_art.png'),
      Secteur(name: "Agriculture de Précision", image: 'assets/images/sectors/robotics.png'),
    ];
  }
}