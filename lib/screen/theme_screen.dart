import 'package:flutter/material.dart';
import 'package:pmsn2024/settings/global_values.dart';
import 'package:pmsn2024/settings/theme_preferences.dart';


class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración de Tema'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Tema Claro'),
            leading: Radio(
              value: 0,
              groupValue: GlobalValues.themeMode.value,
              onChanged: (int? value) {
                _changeTheme(context, value!);
              },
            ),
          ),
          ListTile(
            title: const Text('Tema Oscuro'),
            leading: Radio(
              value: 1,
              groupValue: GlobalValues.themeMode.value,
              onChanged: (int? value) {
                _changeTheme(context, value!);
              },
            ),
          ),
          ListTile(
            title: const Text('Tema Personalizado'),
            leading: Radio(
              value: 2,
              groupValue: GlobalValues.themeMode.value,
              onChanged: (int? value) {
                _changeTheme(context, value!);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _changeTheme(BuildContext context, int value) async {
    GlobalValues.themeMode.value = value;
    await ThemePreference().setTheme(value);
  }
}
