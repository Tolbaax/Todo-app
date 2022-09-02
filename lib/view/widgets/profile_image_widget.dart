import 'package:flutter/material.dart';

Widget profileImage(
    {required double radius, Color borderColor = Colors.black}) {
  return CircleAvatar(
    radius: radius,
    backgroundColor: Colors.transparent,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
            'https://lh3.googleusercontent.com/a-/AFdZucqhuEPt1XueQyXA10U-xqeMj7B-_B2NrKIgKB4K=s96-c',
          ),
          fit: BoxFit.contain,
        ),
        border: Border.all(color: borderColor),
      ),
    ),
  );
}
