import 'package:shared_preferences/shared_preferences.dart';

// Clase que se encarga de manejar las preferencias de la aplicación
class PreferencesService {
  // Claves constantes para guardar las preferencias de tema y fuente
  static const String _themeKey = 'themeIndex'; // variables para tema y fuente
  static const String _fontKey = 'fontFamily';  

  // Método para guardar el índice del tema seleccionado
  Future<void> saveTheme(int themeIndex) async {
    final prefs = await SharedPreferences.getInstance(); // Obtener instancia de SharedPreferences
    await prefs.setInt(_themeKey, themeIndex); // Guardar el índice del tema como un entero
  }

  // Método para guardar la familia de fuente seleccionada
  Future<void> saveFont(String fontFamily) async {
    final prefs = await SharedPreferences.getInstance(); // Obtener instancia de SharedPreferences
    await prefs.setString(_fontKey, fontFamily); // Guardar la familia de fuente como una cadena de texto
  }

  // Método para obtener el índice del tema almacenado
  Future<int> getTheme() async {
    final prefs = await SharedPreferences.getInstance(); // Obtener instancia de SharedPreferences
    return prefs.getInt(_themeKey) ?? 0; // Devuelve el índice almacenado, o 0 (tema claro) si no se ha guardado ningún valor
  }

  // Método para obtener la familia de fuente almacenada
  Future<String> getFont() async {
    final prefs = await SharedPreferences.getInstance(); // Obtener instancia de SharedPreferences
    return prefs.getString(_fontKey) ?? 'Roboto'; // Devuelve la fuente almacenada, o 'Roboto' si no se ha guardado ningún valor
  }
}
