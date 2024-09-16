import 'package:flutter/material.dart';
//definimos la clase 
class Pelicula {
  //colocamos las variables 
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

//constructor de la clase pelicula 
  Pelicula(this.name, this.conName, this.backgroundImage, this.imageTop,
      this.imageSmall, this.imageBlur, this.cupImage, this.description,
      this.lightColor, this.darkColor,this.categoria);


}