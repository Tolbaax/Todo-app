import 'package:flutter/material.dart';

Widget customButton({required screenSize, required text}) {
  return Container(
    height: screenSize.height * 0.085,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        bottomRight: Radius.circular(15.0),
        bottomLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          letterSpacing: 1,
        ),
      ),
    ),
  );
}
