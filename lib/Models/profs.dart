class Profs {
  String pname;
  String iconpath;

  Profs({
    required this.pname,
    required this.iconpath,
  });
  static List<Profs> getProfs() {
    List<Profs> professor = [];
    professor
        .add(Profs(pname: "Mr. Andry", iconpath: 'assets/images/profs/prof3.png'));
    professor.add(Profs(pname: "Mr. Tsoa", iconpath: 'assets/images/profs/prof3.png'));
    professor
        .add(Profs(pname: "Pr. Julien", iconpath: 'assets/images/profs/prof1.jpg'));
    professor
        .add(Profs(pname: "Mme Maeva", iconpath: 'assets/images/profs/prof2.jpg'));
    professor.add(Profs(pname: "Mr Toky", iconpath: 'assets/images/profs/prof3.png'));
    professor
        .add(Profs(pname: "Mr Michel", iconpath: 'assets/images/profs/prof4.png'));
    return professor;
  }
}
