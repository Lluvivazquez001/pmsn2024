import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final conUser = TextEditingController();
  final conPwd = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    //definimos las variables
    TextFormField txtUser = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: conUser,
      decoration: const InputDecoration(prefixIcon: Icon(Icons.person)),
    );
    final txtPwd = TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true, //para los elementos ocultos
      controller: conPwd,
      decoration: const InputDecoration(
          prefixIcon: Icon(Icons
              .password)), //se asocian los controles a las cajas de texto ,
    );

    final ctnCredentials = Positioned(
      bottom: 320,
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        // margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: ListView(
          shrinkWrap: true,
          children: [txtUser, txtPwd],
        ),
      ),
    );

//colocamor el boton:
    final btnLogin = Positioned(
      width: MediaQuery.of(context).size.width * .9,
      bottom:
          220, //para ver que tan separado queremos que este de las cajas de texto
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              //estilo al boton
              backgroundColor: const Color.fromARGB(255, 24, 27, 61)),//color del boton
          onPressed: () {
            isLoading =
                true; //cuando se presione dira que esta cargando entonces, se hace la tarea en 2do plano
            setState(() {});
            Future.delayed(const Duration(milliseconds: 4000)).then((value) => {
                  isLoading = false,
                  setState(() {}),
                  Navigator.pushNamed(context, "/home")
                });
          },
          child: const Text(
            'Validar usuario',
            style: TextStyle(
              color: Color.fromARGB(255, 217, 225, 224), // color de la letra
              fontWeight: FontWeight.bold, // peso de la letra (opcional)
            ),
          )),
    );

    final gifLoading = Positioned(
      top: 130,
      child: Image.asset('assets/loading.gif'),
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/fondo.jpg'))),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: 5,
                child: Image.asset(
                  'assets/imagen2.png',
                  width: 300,
                )),
            ctnCredentials,
            btnLogin, //BOTON LOGIN
            isLoading
                ? gifLoading
                : Container() //? es un operador terneario, por ende dice: si isLoading es true entonces muestrame el gif si no muestrame un container
          ],
        ),
      ),
    );
  }
}
