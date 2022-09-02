import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

Widget noNotesWidget(context) {
  var screenSize = MediaQuery.of(context).size;
  var height = screenSize.height;
  var width = screenSize.width;
  return Align(
      child: Column(
    children: [
      SizedBox(height: height * 0.15),
      Image(
        image: AssetImage('assets/images/No_Notes.png'),
        width: width * 0.85,
      ),
      SizedBox(height: height * 0.02),
      DefaultTextStyle(
        style: TextStyle(fontSize: 23.0, color: Colors.black),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            TyperAnimatedText("There's no notes yet!"),
            TyperAnimatedText("Tab '+' to add new note"),
          ],
        ),
      ),
    ],
  ));
}
