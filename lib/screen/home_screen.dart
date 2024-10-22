import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:pmsn2024/provider/test_provider.dart';
import 'package:pmsn2024/screen/profile_screen.dart';
import 'package:pmsn2024/settings/colors_settings.dart';
import 'package:pmsn2024/settings/global_values.dart';
import 'package:pmsn2024/settings/preferences_services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _themeIndex = 0; // Tema seleccionado por defecto
  String _fontFamily = 'Roboto'; // Fuente seleccionada por defecto
  final PreferencesService _preferencesService = PreferencesService();
  //definimos las variable:
  int index = 0;
  final _key = GlobalKey<ExpandableFabState>();

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
    final testProvider = Provider.of<TestProvider>(context);
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
                  child: Image.asset( 'assets/casa.png')))
        ],
      ),
      //devolver un widget = body
      body: Builder(builder: (context) {
         switch (index) {
          case 0:
            return const Center(
              child: Text('Home Screen'),
            );
          case 1:
            return ProfileScreen(changeTheme: _changeTheme, changeFont: _changeFont);
          case 2:
            return const Center(
              child: Text('Exit Screen'),
            );
          default:
            return ProfileScreen(changeTheme: _changeTheme, changeFont: _changeFont);
        }
      }),
      //endDrawer: Drawer(),
      drawer: myDrawer(testProvider), //colocamos un menu lateral
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.person, title: 'Profile'),
         /* TabItem(
            icon: Icons.woo_commerce_sharp,
            title: 'Personajes',
          ),*/
          TabItem(icon: Icons.exit_to_app, title: 'Exit'),
        ],
      onTap: (int i) => setState(() {
          index = i;
        }),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
          //ahora vamos a colocar el menu
          key: _key,
          children: [
            FloatingActionButton.small(
                heroTag: "btn1",
                onPressed: () {
                  GlobalValues.banThemeDark.value =
                      false; //establecemos la bandera
                },
                child: const Icon(Icons
                    .light_mode) //colocamos el icono para el sol (tema claro)
                ),
            FloatingActionButton.small(
                heroTag: "btn2",
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

  //construimos un widget
  Widget myDrawer(TestProvider testProvider) {
    return Drawer(
      //trabajaremos la propiedad child, contenedor multiple
      child: ListView(
        children: [
           UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/300'), //agregamos un link que nos da imagenes random
              ),
              accountName: Text(testProvider.name),
              accountEmail: Text('20030294@itcelaya.edu.mx')),
          //agregamos un widget
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/db'),
            title: Text('Movies List'),
            subtitle: Text('Database of movies'),
            leading: Icon(Icons.movie),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/peliculas'),
            title: Text('Peliculas'),
            leading: Icon(Icons.movie),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () => Navigator.pushReplacementNamed(context, '/popularMovie'),
            title: Text('Peliculas populares'),
            subtitle: Text('API of movie'),
            leading: Icon(Icons.movie_creation),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () => Navigator.pushReplacementNamed(context, '/login'),
            title: Text('Cerrar Sesion'),
            leading: Icon(Icons.close),
            trailing: Icon(Icons.chevron_right),
          )
        ],
      ),
    );
  }
}
