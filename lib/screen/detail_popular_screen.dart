import 'package:flutter/material.dart';
import 'package:pmsn2024/models/popular_moviedao.dart';
import 'package:pmsn2024/provider/test_provider.dart';
import 'package:provider/provider.dart';

class DetailPopularScreen extends StatefulWidget {
  const DetailPopularScreen({super.key});

  @override
  State<DetailPopularScreen> createState() => _DetailPopularScreenState();
}

class _DetailPopularScreenState extends State<DetailPopularScreen> {
  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context)!.settings.arguments as PopularMovieDao; //esta linea esta recuperando los parametros de una ruta nombrada
    final testProvider = Provider.of<TestProvider>(context);
    return Scaffold(//envolvemos el container dentro de un widget de scafoold
        floatingActionButton: FloatingActionButton(onPressed: ()=> testProvider.name = 'Lluvia'),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              opacity: 0.3,//para que no se vea tanto
              fit: BoxFit.fill, //para que coloque la imagen en toda la pantalla 
            image: NetworkImage('https://image.tmdb.org/t/p/w500/${popular.posterPath}'), //vamos a colocar la imagen en grande como tipo poster 
            ),
        ),
      ),
    );
  }
}
