// ignore_for_file: prefer_const_constructors

//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2024/screen/home_screen.dart';
import 'package:pmsn2024/screen/login_screen.dart';
import 'package:pmsn2024/screen/peliculas_screen.dart';
import 'package:pmsn2024/settings/global_values.dart';
import 'package:pmsn2024/settings/theme_settings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalValues.banThemeDark,
      builder: (context,_,value) { //se recupera true o false de la variable 
        return MaterialApp(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          home: LoginScreen(),
          theme:GlobalValues.banThemeDark.value ? ThemeSettings.darkTheme() : ThemeSettings.lightTheme(context),// para cambiar el tema a oscuro 
          routes: {
            "/home":(context) => HomeScreen(),
            "/peliculas": (context) => PeliculasScreen(),
          },
        );
      }
    ); 
  }
} 