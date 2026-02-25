import 'package:movies_app/models/movie_model.dart';

class MovieDetailsModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final int runtime;
  final List<String> genres;
  final String releaseDate;

  MovieDetailsModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.runtime,
    required this.genres,
    required this.releaseDate,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      runtime: json['runtime'] ?? 0,
      releaseDate: json['release_date'] ?? '',
      genres: (json['genres'] as List)
          .map((genre) => genre['name'].toString())
          .toList(),
    );
  }


  /// دا الفانكشن عشان احول المودل بتاع التفاصيل  لمودل عادي عشان اقدر استخدمه في الفافوريتس
  MovieModel toMovieModel() {
  return MovieModel(
    id: id,
    title: title,
    poster: posterPath,
    rate: voteAverage.toString(),
    releaseDate: releaseDate,
    overview: overview,
  );
}


}
