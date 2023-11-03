import 'package:flutter/material.dart';

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
        .add(Profs(pname: "Mr. Andry", iconpath: 'images/profs/prof3.png'));
    professor
        .add(Profs(pname: "Pr. Julien", iconpath: 'images/profs/prof1.jpg'));
    professor
        .add(Profs(pname: "Mme Maeva", iconpath: 'images/profs/prof2.jpg'));
    professor.add(Profs(pname: "Mr Toky", iconpath: 'images/profs/prof3.png'));
    professor
        .add(Profs(pname: "Mr Michel", iconpath: 'images/profs/prof4.png'));
    return professor;
  }
}
