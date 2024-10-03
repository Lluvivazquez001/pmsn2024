import 'package:flutter/material.dart';

class GlobalValues {
  static ValueNotifier<bool> banThemeDark = ValueNotifier<bool>(false);
  static ValueNotifier<bool> banUpdListMovies = ValueNotifier<bool>(false);

  // Para almacenar el color personalizado
  static ValueNotifier<int> themeIndex = ValueNotifier<int>(0); // 0 = claro, 1 = oscuro, 2 = cálido
}
