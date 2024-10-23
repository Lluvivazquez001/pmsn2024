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

class OnboardingScreen extends StatelessWidget {
 

  // Lista de opciones de fuentes disponibles
  List<String> fonts = ['Roboto', 'Lato', 'Montserrat', 'Pacifico'];
 
  String selectedFont = 'Roboto';

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      // Lista de páginas del onboarding
      pages: [
        PageViewModel(
          title: "¡Bienvenido a la App!", // Título de la primera página
          body:
              "En la siguiente aplicacion encontraras una serie de funciones de peliculas, en donde lograras ver la extensa variedad con la que contamos.",
          image: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20), // Espacio arriba de la animación
                SizedBox(
                  height: 270,
                  child: Lottie.asset('assets/nivel5.json'), // Animación Lottie
                ),
              ],
            ),
          ),
          decoration: PageDecoration(
            // Decoración de la página
            titleTextStyle:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            bodyTextStyle: TextStyle(fontSize: 16),
          ),
        ),

        // Página para configurar tema y fuente
        PageViewModel(
          title: "Configuración de la app",
          bodyWidget: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Selecciona el tema", // Título de la sección de temas
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                // Botones para seleccionar temas (claro, oscuro, personalizado)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                      GlobalValues.themeMode.value = 0;
                      ThemeSettings.lightTheme(); // Aplica el tema claro
                    }, // Tema claro
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.light_mode, color: Colors.white),
                    ),
                    SizedBox(width: 20),
                    FloatingActionButton(
                      onPressed: () {
                      GlobalValues.themeMode.value = 1;
                      ThemeSettings.darkTheme(); // Aplica el tema oscuro
                    }, // Tema oscuro
                      backgroundColor: Colors.black87,
                      child: const Icon(Icons.dark_mode, color: Colors.white),
                    ),
                    SizedBox(width: 20),
                    FloatingActionButton(
                     onPressed: () {
                      GlobalValues.themeMode.value = 2;
                      ThemeSettings.customTheme(); // Aplica el tema oscuro
                    },
                      backgroundColor: Colors.orange,
                      child: const Icon(Icons.local_fire_department,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                // Sección para seleccionar la fuente
                Text(
                  "Selecciona la fuente", // Título de la sección de fuentes
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                // Dropdown para seleccionar una fuente
             
              ],
            ),
          ),
          image: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                SizedBox(
                  child: Lottie.asset(
                      'assets/nivel4.json'), // Otra animación Lottie
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

        // Última página del onboarding
        PageViewModel(
          title: "¡Comienza a Usar!",
          body: "Estás a un paso de comenzar a disfrutar de la aplicación.",
          image: Center(
            child: Lottie.asset('assets/tema1.json'), // Animación final
          ),
          decoration: PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            bodyTextStyle: TextStyle(fontSize: 16),
          ),
        ),
      ],
      // Acción cuando el usuario completa el onboarding
      onDone: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomeScreen()), // Navega a la pantalla principal
        );
      },
      // Acción si el usuario se salta el onboarding
      onSkip: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomeScreen()), // Navega a la pantalla principal
        );
      },
      showSkipButton: true, // Muestra el botón de "Saltar"
      skip: const Text("Saltar"),
      next: const Icon(Icons.arrow_forward),
      done:
          const Text("Comenzar", style: TextStyle(fontWeight: FontWeight.bold)),
      dotsDecorator: const DotsDecorator(
        activeColor: Colors.blue, // Color del indicador activo
        color: Colors.grey, // Color de los indicadores inactivos
        size: Size(10, 10), // Tamaño del punto
        activeSize: Size(12, 12), // Tamaño del punto activo
      ),
    );
  }
}