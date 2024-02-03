// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lvlmindbeta/Models/screenModels/matiereScreen.dart';
import 'package:lvlmindbeta/pages/filesPage.dart';
import 'package:lvlmindbeta/Models/popuphome.dart';
import 'package:lvlmindbeta/Models/matiere.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<Section> section = [];

  void getSection() {
    section = Section.getSection();
  }

  List<Secteur> listsecteur = [];

  void getSecteur() {
    listsecteur = Secteur.getSecteur();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    getSection(); // Pour le contenu du menu popup
    getSecteur(); // Pour la liste des sections
    MediaQueryData mediaQuery = MediaQuery.of(context);
    if (mediaQuery.size.width > 400) {
      return Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 50,
                child:
                    Image(image: AssetImage('assets/images/icons/menubutton.jpg')),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text.rich(TextSpan(
                    text: "Hi there \n\n",
                    style: TextStyle(
                      fontFamily: 'Josefin',
                      color: Color.fromARGB(180, 0, 0, 0),
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                    children: [
                      TextSpan(
                          text:
                              "Let's start a day exciting \n while learning with us",
                          style: TextStyle(
                            fontFamily: 'Josefin',
                            fontSize: 17,
                            color: Color.fromARGB(171, 0, 0, 0),
                          ))
                    ])),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                    width: 90,
                    child: Image.asset(
                      'assets/images/icons/avatar1.jpg',
                      alignment: Alignment.topRight,
                    ))
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            // Catégories
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  elevation: 5,
                  clipBehavior: Clip.antiAlias,
                  color: const Color.fromARGB(255, 121, 38, 238),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(0.5),
                      // TextButton
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          textAlign: TextAlign.center,
                          "TOP",
                          style: TextStyle(
                              fontFamily: 'Josefin',
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      )),
                ),
                //Sliding menu
                listebestmatiere(),
                      
                // Pour ce menu: l'utilisateur peut personnaliser les catégories à afficher
                // en fonction du section
                SizedBox(
                    child: IconButton(
                  onPressed: () {
                    showMenu(
                        context: context,
                        position: const RelativeRect.fromLTRB(500, 320, 0, 0),
                        items: [
                          PopupMenuItem(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 1, vertical: 1),
                              child: SizedBox(
                                width: 150,
                                height: 100,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                        onTap: () {},
                                        title: Text(
                                          section[index].name,
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 63, 63, 63),
                                            fontFamily: 'Josefin',
                                            fontSize: 15,
                                          ),
                                        ),
                                        leading: Icon(
                                          section[index].icon,
                                          size: 20,
                                        ));
                                  },
                                  itemCount: section.length,
                                ),
                              ))
                        ]);
                  },
                  alignment: Alignment.center,
                  icon: const Icon(
                    Icons.menu,
                    weight: 20,
                    color: Colors.blueAccent,
                  ),
                ))
              ],
            ),
            const SizedBox(
              height: 40,
            ),
                      
            // Passons aux catégories
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Category",
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
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Files()));
                      },
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
                      
            // Liste des catégories
            const SizedBox(
              width: 500,
              height: 350,
              child: Category(),
            ),
          ] 
        ),
      );
    } else {
      return Scaffold(
        //bottomNavigationBar: navbar(context),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 50,
                  child:
                      Image(image: AssetImage('assets/images/icons/menubutton.jpg')),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text.rich(TextSpan(
                      text: "Hi there \n\n",
                      style: TextStyle(
                        fontFamily: 'Josefin',
                        color: Color.fromARGB(180, 0, 0, 0),
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                      children: [
                        TextSpan(
                            text:
                                "Let's start a day exciting \n while learning with us",
                            style: TextStyle(
                              fontFamily: 'Josefin',
                              fontSize: 17,
                              color: Color.fromARGB(171, 0, 0, 0),
                            ))
                      ])),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: 90,
                      child: Image.asset(
                        'assets/images/icons/avatar1.jpg',
                        alignment: Alignment.topRight,
                      ))
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              // Catégories
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAlias,
                    color: const Color.fromARGB(255, 121, 38, 238),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(0.5),
                        // TextButton
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            textAlign: TextAlign.center,
                            "TOP",
                            style: TextStyle(
                                fontFamily: 'Josefin',
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        )),
                  ),
                  listebestmatiere(),
                  // Pour ce menu: l'utilisateur peut personnaliser les catégories à afficher
                  // en fonction du section
                  // ToDo: Un menu flottant
                  // Popup Menu
                  SizedBox(
                      child: IconButton(
                    onPressed: () {
                      showMenu(
                          context: context,
                          position: RelativeRect.fill,
                          items: [
                            PopupMenuItem(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 1),
                                child: SizedBox(
                                  width: 150,
                                  height: 80,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                          onTap: () {},
                                          title: Text(
                                            section[index].name,
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 63, 63, 63),
                                              fontFamily: 'Josefin',
                                              fontSize: 15,
                                            ),
                                          ),
                                          leading: Icon(
                                            section[index].icon,
                                            size: 20,
                                          ));
                                    },
                                    itemCount: section.length,
                                  ),
                                ))
                          ]);
                    },
                    alignment: Alignment.center,
                    icon: const Icon(
                      Icons.menu,
                      weight: 20,
                      color: Colors.blueAccent,
                    ),
                  ))
                ],
              ),
              const SizedBox(
                height: 40,
              ),

              // Category section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Category",
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
                        onPressed: () {
                          Navigator.push(context,
                             MaterialPageRoute(builder: ((context) => const MatContent())));
                        },
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

              // Liste des catégories
              const SizedBox(
                width: 500,
                height: 400,
                child: Category(),
              )
            ],
          ),
        ),
      );
    }
  }

  // Liste des matières
  SizedBox listebestmatiere() {
    return SizedBox(
      width: 200,
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 5),
        itemCount: listsecteur.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: SizedBox(
              width: 95,
              height: 38,
              child: Card(
                  elevation: 2,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(listsecteur[index].name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: 'Josefin',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue)),
                  )),
            ),
          );
        },
      ),
    );
  }
}
class category_img {
  String title;
  String image;

  category_img(this.image, this.title);
}

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => CategoryState();
}

// Liste de suggestion des matières
class CategoryState extends State<Category> {
  final List<category_img> category = [
    category_img(
      'assets/images/icons/Electronic.jpg',
      'Electronic',
    ),
    category_img('assets/images/icons/Programming.jpg', 'Programming'),
    category_img('assets/images/icons/management.jpg', 'Management'),
    category_img('assets/images/icons/math.jpg', 'Mathematic')
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10),
        itemCount: category.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {},
              child: Card(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(category[index].image),
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      Text(
                        category[index].title,
                        style: const TextStyle(
                          fontFamily: 'Josefin',
                          fontSize: 15,
                        ),
                      ),
                    ]),
              ));
        });
  }
}
