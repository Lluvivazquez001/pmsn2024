
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pmsn2024/database/movies_database.dart';
import 'package:pmsn2024/models/moviesdao.dart';
import 'package:pmsn2024/settings/global_values.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class MovieView extends StatefulWidget {
   MovieView({super.key, this.moviesDAO});

   MoviesDAO? moviesDAO;

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  //necesitamos un controlador para utilizar los atributos, en donde le vamos a poner nombre similar(txtName) solo que le ponemos el Con para identificar
  TextEditingController conName = TextEditingController();
  TextEditingController conOverview = TextEditingController();
  TextEditingController conImgMovie = TextEditingController();
  TextEditingController conRelease = TextEditingController();

  //realizamos la inicializacion de las variables para usar la bd
  MoviesDatabase? moviesDatabase;

  @override
  void initState() {
    super.initState(); //para saber si existe una conexion de la bd
    moviesDatabase = MoviesDatabase();
    if(widget.moviesDAO != null){
      conName.text = widget.moviesDAO!.nameMovie!;
      conOverview.text =widget.moviesDAO!.overview!;
      conImgMovie.text = widget.moviesDAO!.imgMovie!;
      conRelease.text = widget.moviesDAO!.releaseDate!;
    }
  }

  @override
  Widget build(BuildContext context) {
    //definimos los atributos que va a llevar
    final txtnameMovie = TextFormField(
      //le asociamos el controlador que le corresponde
      controller: conName,
      decoration: const InputDecoration(hintText: 'Nombre de la pelicula'),
    );
    final txtOverview = TextFormField(
      controller: conOverview,
      maxLines: 5,
      decoration: const InputDecoration(hintText: 'Sinopsis de la pelicula'),
    );
    final txtImgMovie = TextFormField(
      controller: conImgMovie,
      decoration: const InputDecoration(hintText: 'Poster de la pelicula'),
    );
    final txtRelease = TextFormField(
      readOnly:
          true, //para que no nos deje escribir y solo seleccionar la fecha
      controller: conRelease,
      decoration: const InputDecoration(hintText: 'Fecha de lanzamiento'),
      //al dar clic nos va a arrojar la accion siguiente:
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2024),
            lastDate: DateTime(2050));
        //lo validamos
        if (pickedDate != null) {
          String formatDate = DateFormat('dd-MM-yy').format(pickedDate);
          conRelease.text = formatDate; //se lo asignamos
          setState(() {}); //para que se reconstruyan todos los widgets
        }
      },
    );

    final btnSave = ElevatedButton(
      onPressed: () {
        //mandamos llamar la accion de moviesDataBase para insertar
        moviesDatabase!.INSERT('tblmovies', {
          //hacemos referencia a los atributos de la tabla
          "nameMovie": conName.text,
          "overview": conOverview.text,
          "idGenre": 1,
          "imgMovie": conImgMovie.text,
          "releaseDate": conRelease.text
        }).then((value) { //que me esta regresando de la tarea asincrona 
          if (value > 0) {
            GlobalValues.banUpdListMovies.value= !GlobalValues.banUpdListMovies.value;
            return QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              text: 'Transaction Completed Successfully!',
              autoCloseDuration: const Duration(seconds: 2),
              showConfirmBtn: false,
            );
          }else{
             return QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              text: 'Something was wrong!',
              autoCloseDuration: const Duration(seconds: 2),
              showConfirmBtn: false,
            );
          }
        });
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[200]),
      child: const Text('Guardar'),
    );

    return ListView(
      padding: EdgeInsets.all(10),
      shrinkWrap:
          true, //aplica para que el listView se ajuste al contenido, en este caso a los txt
      //definimos los objetos a utilizar dentro de un children
      children: [
        //agregamos los elementos txt
        txtnameMovie,
        txtOverview,
        txtImgMovie,
        txtRelease,
        btnSave
      ],
    );
  }
}
