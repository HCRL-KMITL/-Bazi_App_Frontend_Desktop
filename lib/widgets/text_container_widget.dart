import 'package:flutter/material.dart';

Widget textContainer(
    TextStyle tstyle, double width, double height, String text) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(158, 158, 158, 0.2),
          spreadRadius: 3,
          blurRadius: 7,
          offset: Offset(0, 3),
        )
      ],
    ),
    child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          text,
          style: tstyle,
          softWrap: true,
        )),
  );
}
