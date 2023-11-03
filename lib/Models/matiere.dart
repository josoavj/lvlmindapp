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
        Matiere(name: "Project Management", number: "8 Chapters", image: ''));
    return listmatiere;
  }
}
