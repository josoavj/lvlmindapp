// ignore_for_file: no_logic_in_create_state, unused_import, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:lvlmindbeta/main.dart';
import 'package:lvlmindbeta/animation.dart';
import 'package:lvlmindbeta/loginpage.dart';
import 'package:lvlmindbeta/Models/Courses.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  Widget build(BuildContext context) {
    List<CoursesModels> courses = [];
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: EdgeInsets.only(
                  top: 30,
                  left: 10,
                  right: 10,
                )),
                Text.rich(TextSpan(
                    text: "Hi there \n",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontFamily: 'Adlam',
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(
                        text: "Let's start a day exciting \n while learning",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontFamily: 'Adlam',
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ])),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 90,
                  child: Image(
                    image: AssetImage('images/logomin.jpg'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Card(
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: courses.length,
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          courses[index].name,
                          style: const TextStyle(
                            fontFamily: 'Josefin',
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(255, 99, 98, 98),
                            fontSize: 15,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        )),
              ),
            ),
            const Courseslist(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class Courseslist extends StatefulWidget {
  const Courseslist({super.key});

  @override
  CourseslistState createState() => CourseslistState();
}

class CourseslistState extends State<Courseslist> {
  @override
  Widget build(BuildContext context) {
    List<CoursesModels> courses = [];
    /*
    void _getCoursesModels() {
    courses = CoursesModels.getCoursesModels();
    }
     */
    return Card(
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: courses.length,
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          itemBuilder: (BuildContext context, int index) {
            return ElevatedButton(
              onPressed: () {},
              child: Text(
                courses[index].name,
                style: const TextStyle(
                  fontFamily: 'Josefin',
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 99, 98, 98),
                  fontSize: 15,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              )),
    );
  }
}
