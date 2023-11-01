class Courses {
  String name; // Pour le nom de la matière
  int number;
  // Création du constructeur pour la classe
  Courses({
    required this.name,
    required this.number,
  });

  static List<Courses> getCoursesModels() {
    List<Courses> courses = [];
    courses.add(Courses(name: "Electronic", number: 3));
    courses.add(Courses(
      name: "AI",
      number: 4,
    ));
    courses.add(Courses(name: "Data Structure", number: 6));
    courses.add(Courses(name: "Algorithm", number: 8));
    //courses.add(CoursesModels(name: "UI/UX" ,number: 2));
    //courses.add(CoursesModels(name: "Project Management", number: 8));
    return courses;
  }
}

// Pour la liste de catégories
class CName {
  String cname;

  CName({
    required this.cname,
  });

  List<CName> getName() {
    List<CName> cnames = [];
    cnames.add(CName(cname: "TOP"));
    cnames.add(CName(cname: "Electronic"));
    cnames.add(CName(cname: "Programming"));
    return cnames;
  }
}
