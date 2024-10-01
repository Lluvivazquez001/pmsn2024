// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pmsn2024/models/moviesdao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MoviesDatabase {
  //generamos las variables
  static final NAMEDB = 'MOVIESDB';
  static final VERSIONDB = 1;

  //Para conectarnos a la base de datos
  static Database? _database;

  //recuperamos la conexion de la variable donde la tenemos
  Future<Database> get database async {
    if (_database != null)
      return _database!; //si la variable es diferente de null entonces retornala
    return _database = await initDatabase(); //creamos metodo initDatabase
  }

  //metodo de initDatabase
  Future<Database> initDatabase() async {
    Directory folder =
        await getApplicationDocumentsDirectory(); //se accesa a directorios seguros con getAplicationDocumentsDirectory
    String path = join(folder.path,
        NAMEDB); //ruta completa donde se va a guardar la base de datos
    return openDatabase(
      path, //donde se va a guardar la bd
      version:
          VERSIONDB, //se llama en la que se estaba definiendo en donde se va a poner la primer version
      onCreate: (db, version) {
        //al ser la primera vez que se ejecuta se llaman a estos, se crean todos los querys
        String query1 = '''
        CREATE TABLE tblgenre(
           idGenre char(1) PPRIMARY KEY,
           dscgenre VARCHAR(50)
        )
        ''';

        db.execute(query1);

        String query2='''
        CREATE TABLE tblmovies(
          idMovie INTEGER PRIMARY KEY,
          nameMovie VARCHAR(100),
          overview TEXT,
          idGenre char(1),
          imgMovie VARCHAR(150),
          releaseDate CHAR(10),
          CONSTRAINT fk_gen FOREIGN KEY(idGenre) REFERENCES tblgenre(idGenre)
        );''';
        db.execute(query2);
      },
    );
  }//initdatabase 

  //Colocamos los metodos insert, update, etc, Los trabajaremos como metodos asincronos 
  Future<int> INSERT(String table,Map<String,dynamic> row) async {
    var con = await database; //database es la conexion que existe en caso de que no, la crea
    return await con.insert(table, row);
  }
  Future<int> UPDATE(String table,Map<String, dynamic>row) async {
    var con = await database;//recuperamos la conexion de la bd
    return await con.update(table, row, where: 'idMovie = ?', whereArgs: [row['idMovie']]); //whereArgs es una lista, donde se va a extrar el id del conjuno de valores, dependiendo los ? vamos a poner , (despues de'idMovie'] )

  }
  Future<int> DELETE(String table, int idMovie) async { //se le pasa el parametro de idMovie 
    var con = await database;
    return await con.delete(table, where: 'idMovie = ?', whereArgs: [idMovie]); //aqui se manda llamar a la variable 
    
  }
  Future<List<MoviesDAO>> SELECT() async {
    var con = await database;
    var result = await con.query('tblmovies'); //para quitar el Future colocamos el await 
    return result.map((movie) => MoviesDAO.fromMap(movie)).toList(); //cada elemento de result llamalo movie y ve agregandolo a una lista en donde se va a retornar 
    
  }
}
//metodo iterable, se va moviendo sobre los elementos de la lista



