import 'package:flutter/material.dart';

class ThemeSettings {
  static ThemeData lightTheme(BuildContext context){
    final theme = ThemeData.light();
    return theme.copyWith(
      //scaffoldBackgroundColor: const Color.fromARGB(255, 236, 235, 230), //colocamos el color de cambio de pantalla 
    );
  }
  static ThemeData darkTheme(){
    final theme = ThemeData.dark();
    return theme.copyWith(
      //caffoldBackgroundColor: Colors.grey,
    );

  }

  static ThemeData warmTheme(){
    final theme = ThemeData.light();
    return theme.copyWith();
  }
}