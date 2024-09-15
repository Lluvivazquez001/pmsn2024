import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:pmsn2024/screen/profile_screen.dart';
import 'package:pmsn2024/settings/colors_settings.dart';
import 'package:pmsn2024/settings/global_values.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //definimos la variable:
  int index = 0;
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSettings
            .navColor, //para los colores con la variable que generamos
        actions: [
          //IconButton(onPressed: (){}, icon: const Icon(Icons.access_alarm_outlined)),//elemento que es un boton como si fuera un icono
          GestureDetector(
              onTap: () {},
              child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Image.asset('assets/raton.png')))
        ],
      ),
      //devolver un widget = body
      body: Builder(builder: (context) {
        switch (index) {
          case 1:
            return ProfileScreen();
          default:
            return ProfileScreen();
        }
      }),
      //endDrawer: Drawer(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 24, 27, 61),
              ),
              child: Text('Drawer Header'),
            ),
          ],
        ),
      ), //colocamos un menu lateral
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.person, title: 'Profile'),
          TabItem(
            icon: Icons.woo_commerce_sharp, title: 'Personajes',
          ),
          TabItem(icon: Icons.exit_to_app, title: 'Exit'),
        ],
        initialActiveIndex:
            0, // El índice del primer ítem que estará activo al cargar la pantalla
        onTap: (int index) {
          // Verificar si el índice corresponde a "Personajes"
          if (index == 2) {
            // Índice 2 porque 'Personajes' está en la tercera posición (empezando desde 0)
            Navigator.pushNamed(context, "/peliculas");
          }
          // También puedes manejar otras pestañas aquí, si lo deseas
          // else if (index == 0) { ... } para el Home, etc.
        },
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
          //ahora vamos a colocar el menu
          key: _key,
          children: [
            FloatingActionButton.small(
                onPressed: () {
                  GlobalValues.banThemeDark.value =
                      false; //establecemos la bandera
                },
                child: const Icon(Icons
                    .light_mode) //colocamos el icono para el sol (tema claro)
                ),
            FloatingActionButton.small(
                onPressed: () {
                  GlobalValues.banThemeDark.value =
                      true; //establecemos la bandera
                },
                child:
                    const Icon(Icons.dark_mode) //colocamos el icono tema oscuro
                )
          ]),
    );
  }
}
