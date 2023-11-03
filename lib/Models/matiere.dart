class Matiere {
  String name; // Pour le nom de la matière
  int number;
  String image;
  // Création du constructeur pour la classe
  Matiere({
    required this.name,
    required this.number,
    required this.image,
  });

  static List<Matiere> getCoursesModels() {
    List<Matiere> listmatiere = [];
    listmatiere.add(Matiere(name: "Electronic", number: 3, image: ""));
    listmatiere.add(Matiere(
      name: "AI",
      number: 4,
      image: "",
    ));
    listmatiere.add(Matiere(name: "Data Structure", number: 6, image: ""));
    listmatiere.add(Matiere(name: "Algorithm", number: 8, image: ""));
    listmatiere.add(Matiere(name: "UI/UX", number: 2, image: ""));
    listmatiere.add(Matiere(name: "Project Management", number: 8, image: ""));
    return listmatiere;
  }
}
