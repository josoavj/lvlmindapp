class Matiere {
  String name; // Pour le nom de la matière
  String number;
  String image;
  // Création du constructeur pour la classe
  Matiere({
    required this.name,
    required this.number,
    required this.image,
  });

  static List<Matiere> getCoursesModels() {
    List<Matiere> listmatiere = [];
    listmatiere
        .add(Matiere(name: "Electronic", number: "3 Chapters", image: ''));
    listmatiere.add(Matiere(
      name: "AI",
      number: "4 Chapters",
      image: '',
    ));
    listmatiere
        .add(Matiere(name: "Data Structure", number: "6 Chapters", image: ''));
    listmatiere
        .add(Matiere(name: "Algorithm", number: "8 Chapters", image: ''));
    listmatiere.add(Matiere(name: "UI/UX", number: "2 Chapters", image: ''));
    listmatiere.add(
        Matiere(name: "Project \nManagement", number: "8 Chapters", image: ''));
    return listmatiere;
  }
}

// Destiné à la catégorie secteur
class Secteur {
  String name; // Pour le nom du secteur
  String image;
  // Création du constructeur pour la classe
  Secteur({
    required this.name,
    required this.image,
  });

  static List<Secteur> getSecteur() {
    List<Secteur> listsecteur = [];
    listsecteur.add(Secteur(name: "Hacking", image: ''));
    listsecteur.add(Secteur(name: "Web Dev", image: ''));
    listsecteur.add(Secteur(name: "Networking", image: ''));
    listsecteur.add(Secteur(name: "Trading", image: ''));

    listsecteur.add(Secteur(name: "Design", image: ''));

    listsecteur.add(Secteur(name: "Digital Art", image: ''));

    listsecteur.add(Secteur(name: "Painting", image: ''));

    listsecteur.add(Secteur(name: "Astrology", image: ''));

    listsecteur.add(Secteur(name: "Artifical Intelligence", image: ''));

    listsecteur.add(Secteur(name: "Mobile", image: ''));

    listsecteur.add(Secteur(name: "DevOps", image: ''));

    listsecteur.add(Secteur(name: "BIOTECH", image: ''));
    return listsecteur;
  }
}
