import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyText {
  static final LARGETITLE = 34.0;
  static final TITLE1 = 28.0;
  static final TITLE2 = 22.0;
  static final TITLE3 = 20.0;
  static final BODY = 17.0;

  static Widget normal(String text, double size, Color color) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, height: 1.5),
    );
  }

  static Widget bold(String text, double size, Color color) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w700,
          height: 1.5),
    );
  }

  static Widget underline(String text, double size, Color color) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: 'nanumSquareNeo',
        decoration: TextDecoration.underline,
      ),
    );
  }
}
