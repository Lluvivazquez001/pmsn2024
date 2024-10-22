import 'package:flutter/material.dart';
import 'package:pmsn2024/firebase/email_auth.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  // Controladores para los campos de texto de usuario y contraseña
  final conUser = TextEditingController();
  final conPwd = TextEditingController();
  final conEmail = TextEditingController();
  EmailAuth auth = EmailAuth(); //objeto que apunta a los metodos 
  
  // Variable para manejar el estado de carga
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder( //para hacer responsivo 
        builder: (context, constraints) {
          // Variables para obtener la altura y el ancho de la pantalla
          double screenHeight = constraints.maxHeight;
          double screenWidth = constraints.maxWidth;

          return Container(
            height: screenHeight,
            width: screenWidth,
            // imagen de fondo y la decoracion que va a tener 
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/fondo.jpg'),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Logo ubicado en la parte superior de la pantalla
                Positioned(
                  top: screenHeight * 0.05, // Posicionamiento responsivo
                  child: Image.asset(
                    'assets/imagen2.png',
                    width: screenWidth * 0.6, // Ancho responsivo
                  ),
                ),
                // Contenedor para los campos de credenciales
                Positioned(
                  bottom: screenHeight * 0.4, // Posicionamiento responsivo
                  child: Container(
                    width: screenWidth * 0.9, // Ancho responsivo
                    padding: EdgeInsets.all(screenWidth * 0.04), // Padding responsivo
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20), // Bordes redondeados
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Campo de texto para el usuario
                        TextFormField(
                          keyboardType: TextInputType.emailAddress, // Teclado optimizado para email
                          controller: conUser, // Controlador del campo
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person), // Icono al inicio del campo
                            hintText: 'Nombre', // Texto de ayuda
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02), // Espaciado responsivo
                        // Campo de texto para la contraseña
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: conEmail, // Controlador del campo
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email), // Icono al inicio del campo
                            hintText: 'Email', // Texto de ayuda
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02), // Espaciado responsivo
                        // Campo de texto para la contraseña
                        TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: true, // Oculta el texto ingresado
                          controller: conPwd, // Controlador del campo
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock), // Icono al inicio del campo
                            hintText: 'Contraseña', // Texto de ayuda
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Botón de inicio de sesión
                Positioned(
                  bottom: screenHeight * 0.25, // Posicionamiento responsivo
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 24, 27, 61), // Color de fondo del botón
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02, // Padding vertical responsivo
                        horizontal: screenWidth * 0.34, // Padding horizontal responsivo
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // Bordes redondeados del botón
                      ),
                    ),
                    onPressed: () async {
                        isLoading = true;
                        auth.createUser(conEmail.text, conUser.text, conPwd.text).then((value){
                          value ? isLoading = false : isLoading;
                          setState(() {
                            
                           });
                        },
                        );
                          //Navigator.pushReplacementNamed(context, "/login");
                    },
                    child: const Text(
                      'Registro',
                      style: TextStyle(
                        color: Color.fromARGB(255, 217, 225, 224), // Color del texto
                        fontWeight: FontWeight.bold, // Peso de la fuente
                      ),
                    ),
                  ),
                ),
                // Indicador de carga (GIF) que se muestra mientras isLoading es true
                if (isLoading)
                  Positioned(
                    top: screenHeight * 0.3, // Posicionamiento responsivo
                    child: Image.asset(
                      'assets/loading.gif',
                      width: screenWidth * 0.6, // Tamaño responsivo del GIF
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // Libera los controladores cuando el widget se elimina del árbol
    conUser.dispose();
    conPwd.dispose();
    super.dispose();
  }
}
