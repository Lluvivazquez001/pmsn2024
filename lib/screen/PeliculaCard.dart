import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pmsn2024/screen/pelicula.dart';
import 'dart:math' as math;

import 'package:pmsn2024/settings/colors_settings.dart';

class PeliculaCard extends StatelessWidget {
  Pelicula pelicula;
  double pageOffset;
  late double animation;
  double animate = 0;
  double rotate = 0;
  double columnAnimation = 0;
  int index;

  PeliculaCard(this.pelicula, this.pageOffset, this.index);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardWidth = size.width - 60;
    double cardHeight = size.height * .55;
    double count = 0;
    double page;
    rotate = index - pageOffset;
    for (page = pageOffset; page > 1;) {
      page--;
      count++;
    }
    animation = Curves.easeOutBack.transform(page);
    animate = 100 * (count + animation);
    columnAnimation = 50 * (count + animation);
    for (int i = 0; i < index; i++) {
      animate -= 100;
      columnAnimation -= 50;
    }

    return Container(
      child: Stack(
        clipBehavior: Clip.none, children: <Widget>[
          buildTopText(),
          buildBackgroundImage(cardWidth, cardHeight, size),
          buildAboveCard(cardWidth, cardHeight, size),
          buildCupImage(size),
          buildBlurImage(cardWidth, size),
          buildSmallImage(size),
          buildTopImage(cardWidth, size, cardHeight),
        ],
      ),
    );
  }

  Widget buildTopText() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Text(
            pelicula.name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: pelicula.lightColor),
          ),
          Text(
            pelicula.conName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: pelicula.darkColor),
          ),
        ],
      ),
    );
  }

  Widget buildBackgroundImage(double cardWidth, double cardHeight, Size size) {
    return Positioned(
      width: cardWidth,
      height: cardHeight,
      bottom: size.height * .15,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.asset(
            pelicula.backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

Widget buildAboveCard(double cardWidth, double cardHeight, Size size) {
  return Positioned(
    width: cardWidth,
    height: cardHeight,
    bottom: size.height * .15,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: pelicula.darkColor.withOpacity(.50),
        borderRadius: BorderRadius.circular(25),
      ),
      padding: EdgeInsets.all(30),
      child: Transform.translate(
        offset: Offset(-columnAnimation, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Studio glibli',//paralabra que aparece dentro de todas las tarjetas
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              pelicula.description,
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            // Apartado para mostrar la categoría de la película
            Text(
              'Categoría: ${pelicula.categoria}',  // Nuevo apartado
              style: TextStyle(color: Colors.white70, fontSize: 16, fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: 10,
            ),
            // Widget de calificación con estrellas
            RatingBar.builder(
              initialRating: 3,  // Calificación inicial
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating); // Muestra la calificación seleccionada
              },
            ),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  width: 5,
                ),
                Image.asset('assets/gatoL.png'),
                SizedBox(
                  width: 5,
                ),
                Image.asset('assets/gatoM.png'),
                SizedBox(
                  width: 5,
                ),
                Image.asset('assets/gatoXs.png'),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: ColorsSettings.navColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '\$',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '4.',
                      style: TextStyle(fontSize: 19, color: Colors.white),
                    ),
                    Text(
                      '70',
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


//imagen grande
  Widget buildCupImage(Size size) {
    return Positioned(
      bottom: -80,
      right: -50,
      child: Transform.rotate(
        angle: -math.pi / 14 * rotate,
        child: Image.asset(
          pelicula.cupImage,
          height: size.height * .55 - 15,
        ),
      ),
    );
  }

  Widget buildBlurImage(double cardWidth, Size size) {
    return Positioned(
      right: cardWidth / 2 - 60 + animate,
      bottom: size.height * .10,
      child: Image.asset(
        pelicula.imageBlur,
      ),
    );
  }

  Widget buildSmallImage(Size size) {
    return Positioned(
      right: -10 + animate,
      top: size.height * .3,
      child: Image.asset(pelicula.imageSmall),
    );
  }

//escobas 
  Widget buildTopImage(double cardWidth, Size size, double cardHeight) {
    return Positioned(
      left: cardWidth / 4 - animate,
      bottom: size.height * .15 + cardHeight - 25,
      child: Image.asset(pelicula.imageTop),
    );
  }
}
