import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Don't forget to import this line!


class MyFonts {
  // Create a static method to access GoogleFonts
  static TextStyle lato({required double fontSize, required FontWeight fontWeight, required Color color}) {
    return GoogleFonts.lato(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle roboto({ required double fontSize, required FontWeight fontWeight, required Color color}) {
    return GoogleFonts.roboto(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Add other font styles as needed
}
