//se realiza el modelo, ya que tenemos que pasar de un mapa a un objeto 
class PopularMovieDao {

  String backdropPath;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  DateTime releaseDate;
  String title;
  double voteAverage;
  int voteCount;

  PopularMovieDao({
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory PopularMovieDao.fromMap(Map<String, dynamic> popular){
    return PopularMovieDao(
      backdropPath: popular['backdrop_path'],
      id: popular['id'],
      originalLanguage: popular['original_languaje'],
      originalTitle: popular['original_title'],
      overview: popular['overview'],
      popularity: popular['popularity'],
      posterPath: popular['poster_path'],
      releaseDate: popular['release_date'],
      title: popular['title'],
      voteAverage: popular['vote_average'],
      voteCount: popular['vote_count'],
    );
  }


}
