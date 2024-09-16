import 'package:flutter/material.dart';
import 'package:pmsn2024/screen/PeliculaCard.dart';
import 'package:pmsn2024/screen/pelicula.dart';
import 'package:pmsn2024/settings/colors_settings.dart';

// Define una clase para la pantalla de películas que tiene estado
class PeliculasScreen extends StatefulWidget {
  @override
  _PeliculasScreenState createState() => _PeliculasScreenState();
}

// Define el estado para la pantalla de películas
class _PeliculasScreenState extends State<PeliculasScreen> with SingleTickerProviderStateMixin {
  late PageController pageController;  // Controlador para el PageView
  double pageOffset = 0;  // Desplazamiento de la página actual
  late AnimationController controller;  // Controlador para las animaciones
  late Animation animation;  // Animación para efectos visuales

  @override
  void initState() {
    super.initState();
    // Inicializa el controlador de animación con una duración de 800 ms
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOutBack);
    // Inicializa el controlador de páginas con un factor de vista del 80%
    pageController = PageController(viewportFraction: .8);
    pageController.addListener(() {
      setState(() {
        // Actualiza el desplazamiento de la página cuando se desplaza
        pageOffset = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    // Limpia los controladores cuando el estado se elimina
    controller.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;  // Obtiene el tamaño de la pantalla
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            buildToolbar(),  // Construye la barra de herramientas
            buildLogo(size),  // Construye el logo con animación
            buildPager(size),  // Construye el PageView con películas
            buildPageIndecator()  // Construye el indicador de página
          ],
        ),
      ),
    );
  }

  // Construye la barra de herramientas con iconos animados
  Widget buildToolbar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: <Widget>[
          SizedBox(width: 20),
          AnimatedBuilder(
              animation: animation,
              builder: (context, snapshot) {
                return Transform.translate(
                  offset: Offset(-200 * (1.0 - animation.value), 0),
                  child: Image.asset(
                    'assets/ubicacion.png',
                    width: 30,
                    height: 30,
                  ),
                );
              }),
          Spacer(),
          AnimatedBuilder(
              animation: animation,
              builder: (context, snapshot) {
                return Transform.translate(
                  offset: Offset(200 * (1.0 - animation.value), 0),
                  child: Image.asset(
                    'assets/casa.png',
                    width: 30,
                    height: 30,
                  ),
                );
              }),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  // Construye el logo con animación
  Widget buildLogo(Size size) {
    return Positioned(
      top: 10,
      right: size.width / 2 - 25,
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, snapshot) {
            return Transform(
              transform: Matrix4.identity()
                ..translate(0.0, size.height / 2 * (1 - animation.value))
                ..scale(1 + (1 - animation.value)),
              origin: Offset(25, 25),
              child: InkWell(
                onTap: () => controller.isCompleted
                    ? controller.reverse()
                    : controller.forward(),
                child: Image.asset(
                  'assets/logo.png',
                  width: 50,
                  height: 50,
                ),
              ),
            );
          }),
    );
  }

  // Construye el PageView con las tarjetas de películas(los cuadros)
  Widget buildPager(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 70),
      height: size.height - 50,
      child: AnimatedBuilder(
          animation: animation,
          builder: (context, snapshot) {
            return Transform.translate(
              offset: Offset(400 * (1.0 - animation.value), 0),
              child: PageView.builder(
                  controller: pageController,
                  itemCount: getDrinks().length,
                  itemBuilder: (context, index) =>
                      PeliculaCard(getDrinks()[index], pageOffset, index)),
            );
          }),
    );
  }

  // Obtiene una lista de películas
  List<Pelicula> getDrinks() {
    List<Pelicula> list = [];
    list.add(Pelicula(
        'Pon',//titulo 
        'Yo',
        'assets/uno.jpg', //fondo 
        'assets/agua.png', //animacion
        'assets/agua.png',
        'assets/agua.png',
        'assets/ponyo.png',  //png grande 
        '"Ponyo" trata sobre una pececita mágica que desea ser humana y equilibrar los mundos marino y terrestre. \n¡Animate a verla!',
        ColorsSettings.lowRedColor, //lo toma de color_setting ya que en esa parte lo especificammos
        ColorsSettings.lowBlueColor,
        'Animadas'));
    list.add(Pelicula(
        'Ki', 
        'ki',
        'assets/dos.jpg',
        'assets/escoba.png',
        'assets/escoba.png', 
        'assets/escoba.png',
        'assets/kiki3.png',
        'Kiki, una joven bruja, pierde su poder de levitar mientras trabaja repartiendo pan en una nueva ciudad.\n¡Descubre la magia!.',
        ColorsSettings.lowBlodColor,
        ColorsSettings.lowBlue2Color,
        'Ficcion'));
    list.add(Pelicula(
        'Castillo\n',
        'magico',
        'assets/tres.jpg',
        'assets/espantapajaros.png',
        'assets/espantapajaros.png',
        'assets/espantapajaros.png',
        'assets/castillo.png',
        'Una sombrerera, convertida en anciana por una bruja, busca refugio en la casa de un mago. \n¡Embárcate en el encanto!',
        ColorsSettings.lowBYellowColor,
        ColorsSettings.lowBPinkColor,
        'Amor')); 
    return list;
  }

  // Construye el indicador de página con animación
  Widget buildPageIndecator() {
    return AnimatedBuilder(
      animation:controller,
      builder: (context, snapshot) {
        return Positioned(
          bottom: 10,
          left: 10,
          child: Opacity(
            opacity: controller.value,
            child: Row(
              children:
                  List.generate(getDrinks().length, (index) => buildContainer(index)),
            ),
          ),
        );
      }
    );
  }

  // Construye un contenedor para el indicador de página
  Widget buildContainer(int index) {
    double animate =pageOffset-index;
    double size =10;
    Color? color =const Color.fromARGB(255, 79, 117, 241);
    Color? colorEnd =const Color.fromARGB(255, 245, 69, 69); 
    animate=animate.abs();
    if(animate<=1 && animate>=0){
      size=10+10*(1-animate);
      color =ColorTween(begin: Colors.grey,end: colorEnd).transform((1-animate));
    }

    return Container(
      margin: EdgeInsets.all(4),
      height: size,
      width: size,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(20)),
    );
  }
}

