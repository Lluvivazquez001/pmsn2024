import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  static const String _keyTheme = 'theme_mode';
  static const String _keyFont = 'selected_font'; // Clave para la fuente

  Future<void> setTheme(int theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_keyTheme, theme);
  }

  Future<int> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyTheme) ?? 0; // 0 = light, 1 = dark, 2 = custom
  }

  Future<void> setSelectedFont(String font) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyFont, font); // Guarda la fuente seleccionada
  }

  Future<String> getSelectedFont() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyFont) ?? 'Roboto'; // Valor por defecto
  }
}
