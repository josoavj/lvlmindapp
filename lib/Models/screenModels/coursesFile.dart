import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lvlmindbeta/pages/filesPage.dart';

class CoursesContent extends StatefulWidget {
  const CoursesContent({super.key});

  @override
  State <CoursesContent> createState() =>  CoursesContentState();
}

class  CoursesContentState extends State <CoursesContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: (){
            Navigator.pop(context, MaterialPageRoute(builder: (context)=> Files()));
          },),
          title: const Text(
            "Video",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Josefin",
              fontWeight: FontWeight.w700,
              color: Colors.blueAccent,
            ),
          ),
          centerTitle: true,
          actions: const [
            Icon(CupertinoIcons.dot_square_fill)
          ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        children:const [
          
        ]
      ),
    );
  }
}