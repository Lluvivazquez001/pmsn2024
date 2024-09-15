  //esta pantalla tiene que ser renderizable, por eso creamos el statefulWidget  
  import 'package:flutter/material.dart';
import 'package:pmsn2024/database/movies_database.dart';
import 'package:pmsn2024/models/moviesdao.dart';

class MoviesScreen extends StatefulWidget {
    const MoviesScreen({super.key});
  
    @override
    State<MoviesScreen> createState() => _MoviesScreenState();
  }
  
  class _MoviesScreenState extends State<MoviesScreen> {

    //mandamos llamar una instancia de tiempo 
    late MoviesDatabase moviesDB;

    @override
  void initState() {//traernos la clase de movieDatabase
    // TODO: implement initState
    super.initState();
    moviesDB =MoviesDatabase();
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(//lo cambiamos a scaffold
        appBar: AppBar(title: Text('Movies List'),),
        body: FutureBuilder(//envolvemos el ListView en este Futurebuilder 
        future: moviesDB.SELECT(),//se consume el SELECT y lo que hace el FutureBuilder es monitorear 
          builder: (context, AsyncSnapshot<List<MoviesDAO>> snapshot) {//es importante decirle de que tipo va a retornar el AsyncSnapshot<>
            if(snapshot.hasData){ //si ya trae datos nos regresa en caso de que no, el ListView ya tiene como predeterminado el no tiene
              return ListView.builder( //para trabajar hacemos una lista de elementos, la ListView se trabaja porque sabemos cuantos elementos se van a trabajar por eso en este caso vamos a poner un builder porque no sabemos 
              itemBuilder: (context, index){    
                return MovieViewItem();
              },
            );
            }else{
              if(snapshot.hasError){
                return Center(child: Text('Somethins was wrong! :)'),);
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
            }
          }
        ), 
      ); 
    }
  }