import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static Color bgColor = const Color(0xFFe2e2ff);
  static Color mainColor = const Color.fromRGBO(226, 220, 222, 1);
  static Color bgColor2 = const Color.fromARGB(255, 236, 239, 236);
  static Color accentColor = const Color(0xFF0065FF);

  ///setting the cards different color
  static List<Color> cardsColor = [
    Colors.red.shade100,
    Colors.pink.shade100,
    Colors.orange.shade100,
    Colors.yellow.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.blueGrey.shade100,
  ];
  ///setting the text style
   static TextStyle mainTitle = GoogleFonts.roboto(fontSize: 18.0, fontWeight: FontWeight.bold);
   static TextStyle mainContent = GoogleFonts.nunito(fontSize: 16.0, fontWeight: FontWeight.normal);
   static TextStyle dateTitle = GoogleFonts.roboto(fontSize: 13.0, fontWeight: FontWeight.w500);
}


class AppColor {
  static Color primaryColor = const Color.fromARGB(255, 84, 84, 84);
  static Color white = const Color.fromRGBO(250, 243, 240, 1);
  static Color black = const Color.fromARGB(255, 60, 60, 60);
  static Color blackGrey = const Color.fromARGB(255, 60, 60, 60);
  static Color backgroundWhite = const Color.fromRGBO(250, 243, 240, 1);
}
