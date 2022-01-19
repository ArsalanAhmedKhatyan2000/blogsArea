import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var kFontFamily = GoogleFonts.poppins().fontFamily;
const kTextColor = Color(0xFFffffff);
const Color? kPrimaryColor = Colors.purple;

TextStyle textStyle() {
  return TextStyle(
    fontFamily: kFontFamily,
    color: kTextColor,
  );
}

InputDecorationTheme ligthInputTextDecorationTheme() {
  return InputDecorationTheme(
    focusColor: kPrimaryColor,
    fillColor: kPrimaryColor,
    enabledBorder: outlineInputBorder(),
    focusedBorder: outlineInputBorder(),
    errorBorder: outlineInputBorder(),
    border: outlineInputBorder(),
  );
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(color: kPrimaryColor!),
  );
}
