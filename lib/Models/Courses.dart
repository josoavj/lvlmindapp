class CoursesModels {
  String name; // Pour le nom de la matière

  // Création du constructeur pour la classe
  CoursesModels({
    required this.name,
  });

  static List<CoursesModels> getCoursesModels() {
    List<CoursesModels> courses = [];
    courses.add(CoursesModels(name: "Electronic"));
    courses.add(CoursesModels(name: "AI"));
    courses.add(CoursesModels(name: "Data Structure"));
    courses.add(CoursesModels(name: "Algorithm"));
    courses.add(CoursesModels(name: "UI/UX"));
    courses.add(CoursesModels(name: "Project Management"));
    return courses;
  }
}

/*
class Topics extends CoursesModels {
  String tname;
  String category;

  Topics({
    required this.tname,
    required this.category,
    required super.name,
  });

  static List<Topics> getTopics() {
    List<Topics> topics = [];
    topics.add(Topics(tname: "Chapter 1", category: "MSI", name: "Electronic"));
  }
}
*/
