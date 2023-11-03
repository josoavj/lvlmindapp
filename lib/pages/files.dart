import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lvlmindbeta/homepage.dart';
import 'package:lvlmindbeta/pages/edt.dart';
import 'package:lvlmindbeta/pages/profile.dart';
import 'package:lvlmindbeta/Models/profs.dart';

class Files extends StatelessWidget {
  Files({super.key});
  List<Profs> professor = [];
  void getProfs() {
    professor = Profs.getProfs();
  }

  @override
  Widget build(BuildContext context) {
    getProfs();
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.blueAccent,
                size: 25,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homepage(),
                    ));
              })),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(children: [
          const Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 550,
                child: Image(image: AssetImage('images/welcome.jpg')),
              )),
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
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(223, 222, 75, 161),
                      ),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 100,
            width: 600,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 10, right: 10),
              itemCount: professor.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 80,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 50,
                            height: 40,
                            child: Image(
                              height: 30,
                              image: AssetImage(professor[index].iconpath),
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
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                width: 20,
              ),
            ),
          )
        ]),
      ),
      bottomNavigationBar: ClipRRect(
        // Pour obtenir des bords arrondis
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: NavigationBar(
            backgroundColor: const Color.fromARGB(255, 205, 219, 226),
            elevation: 0,
            height: 75,
            selectedIndex: 2,
            indicatorColor: const Color.fromARGB(255, 255, 255, 255),
            destinations: const [
              NavigationDestination(
                icon: Icon(Iconsax.home),
                label: 'Home',
              ),
              NavigationDestination(icon: Icon(Iconsax.calendar), label: 'EDT'),
              NavigationDestination(
                  icon: Icon(Iconsax.folder_2), label: 'Files'),
              NavigationDestination(
                  icon: Icon(Iconsax.profile_circle), label: 'Profile')
            ]),
      ),
    );
  }
}
