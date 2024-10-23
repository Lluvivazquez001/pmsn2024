import 'package:flutter/material.dart';
// Paquete para utilizar Google Fonts
import 'package:introduction_screen/introduction_screen.dart'; // Paquete para la pantalla de introducción
import 'package:lottie/lottie.dart'; // Paquete para animaciones Lottie
import 'package:pmsn2024/settings/global_values.dart';
import 'package:pmsn2024/settings/preferences_services.dart';
import 'package:pmsn2024/settings/theme_notifier.dart';
import 'package:pmsn2024/settings/theme_preferences.dart';
import 'package:pmsn2024/settings/theme_settings.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart'; // Pantalla principal después del onboarding
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Lista de opciones de fuentes disponibles
  List<String> fonts = ['Roboto', 'Lato', 'Montserrat'];
  String selectedFont = 'Roboto';

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "¡Bienvenido a la App!",
          body:
              "En la siguiente aplicación encontrarás una serie de funciones de películas, en donde lograrás ver la extensa variedad con la que contamos.",
          image: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                SizedBox(
                  height: 270,
                  child: Lottie.asset('assets/nivel5.json'),
                ),
              ],
            ),
          ),
          decoration: PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            bodyTextStyle: TextStyle(fontSize: 16),
          ),
        ),
        PageViewModel(
          title: "Configuración de la app",
          bodyWidget: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Selecciona el tema",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () async {
                        GlobalValues.themeMode.value = 0;
                        await ThemePreference()
                            .setTheme(0); // Guardar el tema claro
                        ThemeSettings.lightTheme();
                      },
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.light_mode, color: Colors.white),
                    ),
                    SizedBox(width: 20),
                    FloatingActionButton(
                      onPressed: () async {
                        GlobalValues.themeMode.value = 1;
                        await ThemePreference()
                            .setTheme(1); // Guardar el tema claro
                        ThemeSettings.darkTheme();
                      },
                      backgroundColor: Colors.black87,
                      child: const Icon(Icons.dark_mode, color: Colors.white),
                    ),
                    SizedBox(width: 20),
                    FloatingActionButton(
                      onPressed: () async {
                        GlobalValues.themeMode.value = 2;
                        await ThemePreference()
                            .setTheme(2); // Guardar el tema claro
                        ThemeSettings.customTheme();
                      },
                      backgroundColor: Colors.orange,
                      child: const Icon(Icons.local_fire_department,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  "Selecciona la fuente",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                // Dropdown para seleccionar una fuente
                DropdownButton<String>(
                  value: selectedFont, // Fuente seleccionada por defecto
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.grey),
                  underline: Container(
                    height: 2,
                    color: Colors.blue,
                  ),
                  onChanged: (String? newValue) async {
                    setState(() {
                      selectedFont = newValue!;
                      // Cambia la fuente globalmente
                      GlobalValues.selectedFont.value = selectedFont;
                    });

                    // Guardar la fuente seleccionada en SharedPreferences
                    await ThemePreference().setSelectedFont(selectedFont);
                  },

                  items: fonts.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value), // Texto de la fuente en el dropdown
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          image: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                SizedBox(
                  child: Lottie.asset('assets/nivel4.json'),
                ),
              ],
            ),
          ),
          decoration: PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            bodyTextStyle: TextStyle(fontSize: 16),
          ),
        ),
        PageViewModel(
          title: "¡Comienza a Usar!",
          body: "Estás a un paso de comenzar a disfrutar de la aplicación.",
          image: Center(
            child: Lottie.asset('assets/tema1.json'),
          ),
          decoration: PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            bodyTextStyle: TextStyle(fontSize: 16),
          ),
        ),
      ],
      onDone: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      },
      onSkip: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      },
      showSkipButton: true,
      skip: const Text("Saltar"),
      next: const Icon(Icons.arrow_forward),
      done:
          const Text("Comenzar", style: TextStyle(fontWeight: FontWeight.bold)),
      dotsDecorator: const DotsDecorator(
        activeColor: Colors.blue,
        color: Colors.grey,
        size: Size(10, 10),
        activeSize: Size(12, 12),
      ),
    );
  }
}
