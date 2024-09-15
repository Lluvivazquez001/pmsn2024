import 'package:flutter/material.dart';

class Pelicula {
  String name;
  String conName;
  String backgroundImage;
  String imageTop;
  String imageSmall;
  String imageBlur;
  String cupImage;
  String description;
  Color lightColor;
  Color darkColor;

  var categoria;

  Pelicula(this.name, this.conName, this.backgroundImage, this.imageTop,
      this.imageSmall, this.imageBlur, this.cupImage, this.description,
      this.lightColor, this.darkColor,this.categoria);


}