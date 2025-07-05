import 'package:flutter/cupertino.dart' show BuildContext, CupertinoIcons, Icon, Navigator, State, StatefulWidget, Text, TextStyle, Widget;
import 'package:flutter/material.dart';
import 'package:lvlmindbeta/pages/filesPage.dart';

class ProfListedProfile extends StatefulWidget {
  const ProfListedProfile({super.key});

  @override
  State<ProfListedProfile> createState() => _ProfListedProfileState();
}

class _ProfListedProfileState extends State<ProfListedProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Professors List",
          style: TextStyle(
            fontFamily: 'Josefin',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      centerTitle: true,
      backgroundColor: Colors.blueAccent,
      leading: IconButton(
        onPressed: (){
          Navigator.pop(context, MaterialPageRoute(builder: (context)=> FilesPage()));
        }, 
        icon: const Icon(
          CupertinoIcons.back,
          size: 15,
          color: Colors.white,)),
      ),
    );
  }
}