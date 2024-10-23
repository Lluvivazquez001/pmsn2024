import 'package:flutter/material.dart';

class ThemeSettings {
  static ThemeData lightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.blue,
      brightness: Brightness.light,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.grey,
      brightness: Brightness.dark,
    );
  }

  static ThemeData customTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.orange[100],
      primaryColor: Colors.orange,
      brightness: Brightness.light,
    );
  }
}
