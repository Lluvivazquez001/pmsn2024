import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  static const String _keyTheme = 'theme_mode';

  Future<void> setTheme(int theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_keyTheme, theme);
  }

  Future<int> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyTheme) ?? 0; // 0 = light, 1 = dark, 2 = custom
  }
}
