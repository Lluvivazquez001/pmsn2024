import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Librería para usar fuentes de Google Fonts
import 'package:pmsn2024/firebase_options.dart';
import 'package:pmsn2024/provider/test_provider.dart';
import 'package:pmsn2024/screen/detail_popular_screen.dart';
import 'package:pmsn2024/screen/home_screen.dart'; // Importa la pantalla del Home_Screen
import 'package:pmsn2024/screen/login_screen.dart'; // Importa la pantalla de login
import 'package:pmsn2024/screen/movies_screen.dart';
import 'package:pmsn2024/screen/onboarding_screen.dart'; // Importa el onboarding
import 'package:pmsn2024/screen/peliculas_screen.dart';
import 'package:pmsn2024/screen/popular_screen.dart';
import 'package:pmsn2024/screen/profile_screen.dart'; // Importa la pantalla de profile
import 'package:pmsn2024/screen/registro_screen.dart';
import 'package:pmsn2024/screen/theme_screen.dart';
import 'package:pmsn2024/settings/global_values.dart';
import 'package:pmsn2024/settings/preferences_services.dart'; // Importa el servicio de preferencias para guardar configuraciones
import 'package:pmsn2024/settings/theme_preferences.dart';
import 'package:pmsn2024/settings/theme_settings.dart';
import 'package:provider/provider.dart'; // Importa la configuración de temas

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  int savedTheme = await ThemePreference().getTheme();
  String savedFont = await ThemePreference().getSelectedFont();
  GlobalValues.selectedFont.value = savedFont;

  GlobalValues.themeMode.value = savedTheme;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalValues.themeMode,
      builder: (context, themeMode, _) {
        return ValueListenableBuilder(
          valueListenable: GlobalValues.selectedFont,
          builder: (context, selectedFont, _) {
            return ChangeNotifierProvider(
              create: (context) => TestProvider(),
              child: MaterialApp(
                title: 'Material App',
                debugShowCheckedModeBanner: false,
                home: LoginScreen(),
                theme: combineThemeAndFont(themeMode, selectedFont),
                routes: {
                  "/home": (context) => HomeScreen(),
                  "onboarding": (context) => OnboardingScreen(),
                  "/login": (context) => LoginScreen(),
                  "/popularMovie": (context) => PopularScreen(),
                  "/peliculas": (context) => PeliculasScreen(),
                  "/db": (context) => MoviesScreen(),
                  "/details": (context) => DetailPopularScreen(),
                  "/registro": (context) => RegistroScreen(),
                  "/theme": (context) => ThemeSettingsScreen(),
                },
              ),
            );
          },
        );
      },
    );
  }

  ThemeData getThemeByMode(int mode) {
    switch (mode) {
      case 1:
        return ThemeSettings.darkTheme();
      case 2:
        return ThemeSettings.customTheme();
      default:
        return ThemeSettings.lightTheme();
    }
  }

  TextTheme getTextThemeByFont(String font) {
    return GoogleFonts.getTextTheme(font);
  }

  ThemeData combineThemeAndFont(int mode, String font) {
    ThemeData theme = getThemeByMode(mode);
    TextTheme textTheme = getTextThemeByFont(font);
    return theme.copyWith(textTheme: textTheme);
  }
}
