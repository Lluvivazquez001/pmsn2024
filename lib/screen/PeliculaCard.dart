import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Librería para crear barras de calificación
import 'package:pmsn2024/screen/pelicula.dart'; // Clase Pelicula que contiene los datos de cada película
import 'dart:math' as math; // Importa funciones matemáticas como rotaciones

import 'package:pmsn2024/settings/colors_settings.dart'; // Importa configuraciones de colores

// Widget PeliculaCard que representa la tarjeta de una película
class PeliculaCard extends StatelessWidget {
  Pelicula pelicula; // Objeto que contiene los detalles de la película
  double pageOffset; // Desplazamiento  para animaciones
  late double animation; // Valor de la animación
  double animate = 0; // Control del desplazamiento en la animación
  double rotate = 0; // Valor de rotación para efectos visuales
  double columnAnimation = 0; // Control de animación para las columnas de texto
  int index; // Índice de la tarjeta en la lista

  // Constructor que inicializa la película, el desplazamiento de página y el índice
  PeliculaCard(this.pelicula, this.pageOffset, this.index);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Obtiene el tamaño de la pantalla
    double cardWidth = size.width - 60; // Define el ancho de la tarjeta
    double cardHeight = size.height * .55; // Define la altura de la tarjeta
    double count = 0;
    double page;
    rotate = index - pageOffset; // Calcula la rotación según el desplazamiento de página

    // Ajustes para la animación según el desplazamiento de página
    for (page = pageOffset; page > 1;) {
      page--;
      count++;
    }
    animation = Curves.easeOutBack.transform(page); // Aplica una curva de animación suave
    animate = 100 * (count + animation); // Ajusta la posición de la animación
    columnAnimation = 50 * (count + animation); // Ajusta la animación para el texto

    // Desplaza y ajusta las animaciones para cada tarjeta
    for (int i = 0; i < index; i++) {
      animate -= 100;
      columnAnimation -= 50;
    }

    // Retorna la estructura de la tarjeta de película
    return Container(
      child: Stack(
        clipBehavior: Clip.none, // Permite que los elementos sobresalgan del contenedor
        children: <Widget>[
          buildTopText(), // Texto superior con el nombre de la película
          buildBackgroundImage(cardWidth, cardHeight, size), // Imagen de fondo
          buildAboveCard(cardWidth, cardHeight, size), // Tarjeta de contenido
          buildCupImage(size), // Imagen grande (principal) de la película
          buildBlurImage(cardWidth, size), // Imagen secundaria (pequeña)
          buildSmallImage(size), // Imagen difuminada
          buildTopImage(cardWidth, size, cardHeight), // Imagen superior adicional
        ],
      ),
    );
  }

  // Método para construir el texto superior con el nombre de la película
  Widget buildTopText() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20, // Espaciado entre el borde y el texto
          ),
          // Nombre principal de la película
          Text(
            pelicula.name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50, // Tamaño grande para el nombre de la película
                color: pelicula.lightColor), // Color claro
          ),
          // Subtítulo o complemento del nombre de la película
          Text(
            pelicula.conName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: pelicula.darkColor), // Color oscuro para contraste
          ),
        ],
      ),
    );
  }

  // Construye la imagen de fondo de la tarjeta
  Widget buildBackgroundImage(double cardWidth, double cardHeight, Size size) {
    return Positioned(
      width: cardWidth,
      height: cardHeight,
      bottom: size.height * .15, // Ajuste de la posición vertical
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30), // Margen horizontal
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25), // Bordes redondeados
          child: Image.asset(
            pelicula.backgroundImage, // Imagen de fondo de la película
            fit: BoxFit.cover, // Ajusta la imagen al tamaño del contenedor
          ),
        ),
      ),
    );
  }

  // Construye la tarjeta con detalles encima de la imagen de fondo
  Widget buildAboveCard(double cardWidth, double cardHeight, Size size) {
    return Positioned(
      width: cardWidth,
      height: cardHeight,
      bottom: size.height * .15, // Ajuste de la posición vertical
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: pelicula.darkColor.withOpacity(.50), // Color oscuro con opacidad
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.all(30),
        child: Transform.translate(
          offset: Offset(-columnAnimation, 0), // Aplicación de la animación en la posición del texto
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Texto que aparece en todas las tarjetas
              Text(
                'Studio glibli',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10), // Espaciado entre elementos
              Text(
                pelicula.description, // Descripción de la película
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              SizedBox(height: 10),
              // Categoría de la película
              Text(
                'Categoría: ${pelicula.categoria}',
                style: TextStyle(color: Colors.white70, fontSize: 16, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 10),
              // Barra de calificación de estrellas
              RatingBar.builder(
                initialRating: 3, // Valor inicial de la calificación
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true, // Permite calificación con medias estrellas
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber, // Color de las estrellas
                ),
                onRatingUpdate: (rating) {
                  print(rating); // Muestra la calificación en la consola
                },
              ),
              Spacer(), // Espaciador para empujar los elementos al final
              // Imágenes de gatos (decorativas)
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(width: 5),
                  Image.asset('assets/gatoL.png'), // Gato grande
                  SizedBox(width: 5),
                  Image.asset('assets/gatoM.png'), // Gato mediano
                  SizedBox(width: 5),
                  Image.asset('assets/gatoXs.png'), // Gato pequeño
                ],
              ),
              SizedBox(height: 15),
              // Contenedor decorativo para mostrar un precio
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: ColorsSettings.navColor, // Color definido en ColorsSettings
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(width: 20),
                      Text(
                        '\$', // Símbolo de moneda
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '4.', // Parte entera del precio
                        style: TextStyle(fontSize: 19, color: Colors.white),
                      ),
                      Text(
                        '70', // Parte decimal del precio
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Imagen principal (grande) de la película
  Widget buildCupImage(Size size) {
    return Positioned(
      bottom: -80,
      right: -50,
      child: Transform.rotate(
        angle: -math.pi / 14 * rotate, // Rotación según la posición de la tarjeta
        child: Image.asset(
          pelicula.cupImage,
          height: size.height * .55 - 15, // Ajuste del tamaño de la imagen
        ),
      ),
    );
  }

  // Imagen difuminada o secundaria que aparece en la tarjeta
  Widget buildBlurImage(double cardWidth, Size size) {
    return Positioned(
      right: cardWidth / 2 - 60 + animate, // Posición basada en la animación
      bottom: size.height * .10,
      child: Image.asset(
        pelicula.imageBlur, // Imagen secundaria (difuminada)
      ),
    );
  }

  // Imagen pequeña adicional que aparece en la tarjeta
  Widget buildSmallImage(Size size) {
    return Positioned(
      right: -10 + animate, // Posición basada en la animación
      top: size.height * .3,
      child: Image.asset(pelicula.imageSmall), // Imagen pequeña
    );
  }

  // Imagen superior que aparece en la parte superior de la tarjeta
  Widget buildTopImage(double cardWidth, Size size, double cardHeight) {
    return Positioned(
      left: cardWidth / 4 - animate, // Posición ajustada por la animación
      bottom: size.height * .15 + cardHeight - 25,
      child: Image.asset(pelicula.imageTop), // Imagen superior
    );
  }
}
