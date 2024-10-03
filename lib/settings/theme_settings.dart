import 'package:flutter/material.dart';

// Clase que define los temas de la aplicación
class ThemeSettings {
  
  // Método estático que define el tema claro
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData.light().copyWith(
      primaryColor: Colors.blue, // Color primario del tema claro
      brightness: Brightness.light, // Define que la interfaz es de tipo "claro"
    );
  }

  // Método estático que define el tema oscuro
  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.grey[850], // Color primario para el tema oscuro
      brightness: Brightness.dark, // Define que la interfaz es de tipo "oscuro"
    );
  }

  // Método estático que define un tema cálido
  static ThemeData warmTheme() {
    return ThemeData(
      primaryColor: Colors.orange, // Color primario del tema cálido
      brightness: Brightness.light, // Define que la interfaz es de tipo "claro"
      scaffoldBackgroundColor: Colors.amber[50], // Color de fondo de la estructura principal de la aplicación
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.orangeAccent, // Color de fondo del AppBar
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.deepOrange, // Color de los botones
        textTheme: ButtonTextTheme.primary, // Color del texto de los botones
      ),
    );
  }
}
