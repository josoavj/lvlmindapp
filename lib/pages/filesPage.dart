// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lvlmindbeta/Models/screenModels/coursesFile.dart';
import 'package:lvlmindbeta/Models/screenModels/profInfo.dart';
import 'package:lvlmindbeta/Models/screenModels/profsList.dart';
import 'package:lvlmindbeta/Models/profs.dart';
import 'package:lvlmindbeta/Models/matiere.dart';



class Files extends StatefulWidget {
  Files({Key? key}) : super(key: key);

  @override
  _FilesState createState() => _FilesState();
}

class _FilesState extends State<Files> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<Matiere> matiere = [];
  List<Profs> professor = [];

  @override
  void initState() {
    super.initState();
    getCoursesModel();
    getProfs();
  }

  void getCoursesModel() {
    setState(() {
      matiere = Matiere.getCoursesModels();
    });
  }

  void getProfs() {
    setState(() {
      professor = Profs.getProfs();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    getCoursesModel();
    getProfs();
    return Scaffold(
      appBar: appbar(context),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        children:[
          const Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 650,
                child: Image(image: AssetImage('assets/images/icons/welcome.jpg')),
              )),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Teacher",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Josefin',
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(166, 0, 0, 0),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProfListedProfile()));
                    },
                    child: const Text(
                      "See all",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(223, 222, 75, 161),
                      ),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 110,
            width: 550,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 5, right: 5),
              itemCount: professor.length,
              itemBuilder: (context, index) {
                return Container(
                    width: 100,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProfProfile()));
                      },
                      child: Card(
                        elevation: 2,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [ 
                              SizedBox(
                                  width: 50,
                                  height: 40,
                                  child: Image(
                                    height: 30,
                                    image:
                                        AssetImage(professor[index].iconpath, ),
                                        errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return const Text(
                              "Error while \n getting data",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 3, 93, 6),
                                  fontSize: 10),
                            );}
                                  )),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                professor[index].pname,
                                style: const TextStyle(
                                  fontFamily: 'Josefin',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ]),
                      ),
                    ));
              },
              separatorBuilder: (context, index) => const SizedBox(
                width: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Courses",
              style: TextStyle(
                  fontFamily: 'Josefin',
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(168, 0, 0, 0)),
            ),
          ),
          SizedBox(
            height: 450,
            width: 1000,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 25),
              itemCount: matiere.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const CoursesContent()));
                      },
                      leading: SizedBox(
                        child: Image(
                          height: 20,
                          image: AssetImage(
                            matiere[index].image,
                          ),
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return const Text(
                              "Error while \n getting data",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 3, 93, 6),
                                  fontSize: 10),
                            );
                          },
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            matiere[index].name,
                            style: const TextStyle(
                              fontFamily: 'Josefin',
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                              color: Color.fromARGB(255, 65, 64, 64),
                            ),
                          ),
                          Text(
                            matiere[index].number,
                            style: const TextStyle(
                                fontFamily: 'Josefin',
                                fontSize: 13,
                                color: Colors.greenAccent),
                          ),
                        ],
                      )),
                );
              },
            ),
          ),
        ]), 
    );
  }

  }

  // Barre d'application
  AppBar appbar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const Text(
        'Course materials',
        style: TextStyle(
          fontFamily: 'Josefin',
          fontSize: 20,
          color: Colors.blue,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
