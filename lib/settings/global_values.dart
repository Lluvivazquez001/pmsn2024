import 'package:flutter/material.dart';

class GlobalValues {
  static ValueNotifier banThemeDark = ValueNotifier(false);
  static ValueNotifier<bool> banUpdListMovies = ValueNotifier<bool>(false);
  static ValueNotifier<int> themeMode = ValueNotifier(0);
  static ValueNotifier<String> selectedFont = ValueNotifier<String>('Roboto');

  // Para almacenar el color personalizado
}
