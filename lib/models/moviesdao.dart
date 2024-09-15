
class MoviesDAO {
  //al colocar atributos con ? es porque son propenso a que sean nulos 
  //Generamos los atributos de la bd, es decir el modelo de la tabla 
  int? idMovie;
  String? nameMovie;
  String? overview;
  String? idGenre;
  String? imgMovie;
  String? releaseDate;

  //Hacemos un constructor que recibe los parametros
  MoviesDAO({this.idMovie,this.nameMovie, this.overview, this.idGenre, this.imgMovie, this.releaseDate});

  //generamos un constructor nombrado, el factory nos permite mandar llamar al de arriba
  factory MoviesDAO.fromMap(Map<String, dynamic> movie){
    return MoviesDAO(//retornamos un objeto, donde el orden no importa
      idGenre: movie['idGenre'],
      idMovie: movie['idMovie'],
      imgMovie: movie['imgMovie'],
      nameMovie: movie['nameMovie'],
      overview: movie['overview'],
      releaseDate: movie['releaseDate']
      ); 
  }
}