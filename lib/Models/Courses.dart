class CoursesModels {
  String name; // Pour le nom de la matière

  // Création du constructeur pour la classe
  CoursesModels({
    required this.name,
  });

  List<CoursesModels> getCoursesModels() {
    List<CoursesModels> courses = [];
    courses.add(CoursesModels(name: "Electronic"));
    courses.add(CoursesModels(name: "AI"));
    courses.add(CoursesModels(name: "Data Structure"));
    courses.add(CoursesModels(name: "Algorithm"));
    courses.add(CoursesModels(name: ""));
    return courses;
  }
}
