import 'package:flutter/material.dart';

class TestProvider extends ChangeNotifier{
  //definimos variable, en donde se van a trabajar variables privadas
  //Al trabajar variables privadas tenemos que poner get y set 
  String _name = 'Lluvia Guadalupe Alvarez Vazquez';
  String get name => _name;
  set name(String value){
    //debemos de nofiticar que esas variables van a cambiar, por eso ponemos el notifyListeners 
    _name = value;
    notifyListeners();

  }
}