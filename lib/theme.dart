import 'package:blogs_area/constraints.dart';
import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.purple,
      primaryColor: kPrimaryColor,
      backgroundColor: Colors.white,
      canvasColor: Colors.white,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: (Theme.of(context).textTheme.bodyText1!.fontSize!) * 1.5,
          fontWeight: FontWeight.bold,
        ),
      ),
      // textTheme: TextTheme(
      //   bodyText1: textStyle(),
      //   bodyText2: textStyle(),
      // ),
      inputDecorationTheme: ligthInputTextDecorationTheme(),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: kPrimaryColor,
      backgroundColor: Colors.white,
      canvasColor: Colors.white,
      textTheme: TextTheme(
        bodyText1: textStyle(),
        bodyText2: textStyle(),
      ),
      inputDecorationTheme: ligthInputTextDecorationTheme(),
    );
  }
}
