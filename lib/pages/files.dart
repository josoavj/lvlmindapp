import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lvlmindbeta/homepage.dart';
import 'package:lvlmindbeta/pages/edt.dart';
import 'package:lvlmindbeta/pages/profile.dart';
import 'package:lvlmindbeta/Models/profs.dart';
import 'package:lvlmindbeta/Models/matiere.dart';

class Files extends StatelessWidget {
  Files({super.key});
  List<Matiere> matiere = [];
  void getCoursesModel() {
    matiere = Matiere.getCoursesModels();
  }

  List<Profs> professor = [];
  void getProfs() {
    professor = Profs.getProfs();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    getCoursesModel();
    getProfs();
    return Scaffold(
      appBar: appbar(context),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(children: [
          const Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 650,
                child: Image(image: AssetImage('images/icons/welcome.jpg')),
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
                    // Redirection vers une page contenant toutes les catégories
                    // Categories = Matières
                    onPressed: () {},
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
              padding: const EdgeInsets.only(left: 10, right: 10),
              itemCount: professor.length,
              itemBuilder: (context, index) {
                return Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: GestureDetector(
                      onTap: () {},
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
                                        AssetImage(professor[index].iconpath),
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
            height: 234,
            width: 1000,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 25),
              itemCount: matiere.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                      onTap: () {},
                      leading: SizedBox(
                        child: Image(
                          height: 20,
                          image: AssetImage(
                            matiere[index].image,
                          ),
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return const Text(
                              "Image loading problem",
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
      ),
      bottomNavigationBar: navbar(context),
    );
  }

  // Barre d'application
  AppBar appbar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: Container(
        alignment: Alignment.center,
        child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.blueAccent,
              size: 20,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Homepage(),
                  ));
            }),
      ),
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

  // Barre de navigation
  Container navbar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 25,
            offset: const Offset(0, 20))
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: NavigationBar(
            onDestinationSelected: (index) {
              switch (index) {
                case 0:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Homepage()));
                  break;
                case 1:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Schedule()));
                  break;
                case 2:
                  // Cette page
                  break;
                case 3:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Profile()));
                  break;
              }
            },
            backgroundColor: const Color.fromARGB(148, 55, 188, 255),
            elevation: 0,
            height: 75,
            selectedIndex: 2,
            indicatorColor: const Color.fromARGB(255, 255, 255, 255),
            destinations: const [
              NavigationDestination(
                icon: Icon(Iconsax.home_2),
                label: 'Home',
              ),
              NavigationDestination(icon: Icon(Iconsax.calendar), label: 'EDT'),
              NavigationDestination(
                icon: Icon(Iconsax.folder_2),
                label: 'Files',
              ),
              NavigationDestination(
                  icon: Icon(Iconsax.profile_circle), label: 'Profile')
            ]),
      ),
    );
  }
}
