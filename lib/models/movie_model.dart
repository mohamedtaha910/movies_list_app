class MovieModel {
  
  final int id;
  final String title;
  final String poster;
  final String overview;
  final String rate;
  final String releaseDate;
  // final String backdrop;

  MovieModel({
    required this.id,
    required this.title,
    required this.poster,
    required this.overview,
    required this.rate,
    required this.releaseDate,
    // required this.backdrop ,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? '',
      poster: json['poster_path'] ?? '',
      overview: json['overview'] ?? '',
      rate: json['vote_average'].toString(),
      releaseDate: json['release_date'] ?? '',
      // backdrop: json['backdrop_path'],
    );
  }


  /// hive دي فانكشن عشان احول المودل لماب عشان اقدر اخزنها في 
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'posterPath': poster,
      'overview': overview,
      'voteAverage': rate,
      'releaseDate': releaseDate,
    };
  }

  ///  دا الفانكشن عشان احول الماب لمودل لما احتاجها 
  factory MovieModel.fromMap(Map map) {
    return MovieModel(
      id: map['id'],
      title: map['title'],
      poster: map['posterPath'],
      rate: map['voteAverage'].toString(),
      releaseDate: map['releaseDate'],
      overview: map['overview'],
    );
  }

}
