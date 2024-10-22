import 'package:flutter/material.dart';
import 'package:pmsn2024/models/popular_moviedao.dart';
import 'package:pmsn2024/network/popular_api.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  PopularApi? popularApi;

  @override
  void initState() {
    super.initState();
    popularApi = PopularApi(); //Para que se inicialice la pantalla
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //se trabajara el FutureBuilder
      body: FutureBuilder(
          future: popularApi!.getPopularMovies(), //mandamos llamar al popularApi, no nulo para asegurarnos que va a traer algo
          builder: (context, AsyncSnapshot<List<PopularMovieDao>> snapshot) {
            //accion que va a ejecutar o que va a constuir
            //mandaremos si va a traer errores
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //cuantas columnas necesitamos del Grid
                    childAspectRatio: .7 , //abarca mas esoacio la imagen
                    crossAxisSpacing: 10,//espaciado entre cada elemento de las x
                    mainAxisExtent: 10, //espaciado sobre las y
                    ),
                itemBuilder: (context, index) {
                  return cardPopular(snapshot.data![index]); //trabajamos con una interpolacion de strings 
                },
              );
            } else {
              //hacemos una verificacion del snapchot para saber si tiene un error
              if(snapshot.hasError){
                return const Center(
                  child: Text('Somethins is wrong :('),
                );
              }else{
                return const Center(
                  child:  CircularProgressIndicator(),
                );
              }
            }
          }
          ),
    );
  }

  //hacemos una plantilla 
  Widget cardPopular(PopularMovieDao popular){
    return GestureDetector( //envolvemos el container dentro de un widget
      onTap: () => Navigator.pushNamed(context,'/details', arguments: popular), //no sva a mandar a la pantalla 
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration( //le vamos a poner un borde redondeado 
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.fill, //para que abarque mas el tamanio del espacio de las tarjetas
              image: NetworkImage('https://image.tmdb.org/t/p/w500/${popular.posterPath}')
            )
          ),
          child: Stack(//queremos que el texto se encime  por eso colocamos stack o igual puede ser un column
            alignment: Alignment.bottomCenter,
            children: [
              Opacity(
                opacity: 0.7, //envolvemos el container dentro de un widget el cual se llama OPacity
                child: Container(
                  child: Text(popular.title, style: TextStyle(color: Colors.white),), //para que se coloque el texto de la pelicula y le vamos a modificar las propiedades como lo son color
                  color: Colors.black,
                  height: 50,
                  width: MediaQuery.of(context).size.width, //nos va a dar el ancho de la pantalla 
                ),
              )
            ],
          ), 
        ),
      ),
    );

  }

}
