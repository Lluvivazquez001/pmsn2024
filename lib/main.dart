import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Librería para usar fuentes de Google Fonts
import 'package:pmsn2024/screen/home_screen.dart'; // Importa la pantalla del Home_Screen
import 'package:pmsn2024/screen/login_screen.dart'; // Importa la pantalla de login
import 'package:pmsn2024/screen/onboarding_screen.dart'; // Importa el onboarding
import 'package:pmsn2024/screen/profile_screen.dart'; // Importa la pantalla de profile
import 'package:pmsn2024/settings/preferences_services.dart'; // Importa el servicio de preferencias para guardar configuraciones
import 'package:pmsn2024/settings/theme_settings.dart'; // Importa la configuración de temas

void main() {
  runApp(const MyApp()); // Llama a la aplicación principal
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState(); // Crea el estado del widget MyApp
}

class _MyAppState extends State<MyApp> {
  // Variables para manejar el tema y la fuente seleccionados
  int _themeIndex = 0; // Tema seleccionado por defecto
  String _fontFamily = 'Roboto'; // Fuente seleccionada por defecto
  final PreferencesService _preferencesService = PreferencesService(); // Servicio para gestionar las preferencias (SharedPreferences)

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Carga las preferencias guardadas al iniciar la aplicación
  }

  // Método para cargar las preferencias del usuario desde SharedPreferences
  Future<void> _loadPreferences() async {
    final themeIndex = await _preferencesService.getTheme(); // Obtiene el tema guardado
    final fontFamily = await _preferencesService.getFont(); // Obtiene la fuente guardada
    setState(() {
      _themeIndex = themeIndex; // Actualiza el tema con el valor guardado
      _fontFamily = fontFamily; // Actualiza la fuente con el valor guardado
    });
  }

  // Cambia el tema y guarda la preferencia
  void _changeTheme(int index) {
    setState(() {
      _themeIndex = index; // Cambia el tema actual
      _preferencesService.saveTheme(index); // Guarda el tema seleccionado en SharedPreferences
    });
  }

  // Cambia la fuente y guarda la preferencia
  void _changeFont(String fontFamily) {
    setState(() {
      _fontFamily = fontFamily; // Cambia la fuente actual
      _preferencesService.saveFont(fontFamily); // Guarda la fuente seleccionada en SharedPreferences
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App', // Título de la aplicación
      debugShowCheckedModeBanner: false, // Oculta la marca de debug en la esquina
      theme: _getThemeData(), // Aplica el tema basado en el índice seleccionado
      home: LoginScreen(), // Pantalla inicial (se puede cambiar según el flujo)
      routes: {
        "/home": (context) => HomeScreen(), // Ruta para la pantalla principal
        "/onboarding": (context) => OnboardingScreen(changeTheme: _changeTheme, changeFont: _changeFont), // Ruta para la pantalla de Onboarding
        "/profile": (context) => ProfileScreen(), // Ruta para la pantalla de perfil
        "/login": (context) => LoginScreen() // Ruta para la pantalla de inicio de sesión
      },
    );
  }

  // Método para obtener el tema de la aplicación basado en la selección del usuario
  ThemeData _getThemeData() {
    ThemeData baseTheme;

    switch (_themeIndex) {
      case 0:
        baseTheme = ThemeSettings.lightTheme(context); // Tema claro
        break;
      case 1:
        baseTheme = ThemeSettings.darkTheme(); // Tema oscuro
        break;
      case 2:
        baseTheme = ThemeSettings.warmTheme(); // Tema cálido
        break;
      default:
        baseTheme = ThemeSettings.lightTheme(context); // Tema claro por defecto
    }

    // Aplica la fuente seleccionada a los estilos de texto del tema
    return baseTheme.copyWith(
      textTheme: GoogleFonts.getTextTheme(_fontFamily, baseTheme.textTheme),
    );
  }
}
