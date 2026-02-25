import 'package:hive_flutter/adapters.dart';
import 'package:movies_app/models/movie_model.dart';

class FavouritesService {

  final Box box = Hive.box('favBox');

  /// Check if a movie is in favourites
  bool isFavourite(int id) => box.containsKey(id);

  /// Add or remove a movie from favourites
  void addFavourite(MovieModel movie) {
    if (isFavourite(movie.id)) {
      box.delete(movie.id);
    } else {
      box.put(movie.id, movie.toMap());
    }
  }

  /// Get all favourite movies
  List<MovieModel> getAllFavourites() {
    List<MovieModel> favourites = [];
    for (var item in box.values) {
      favourites.add(MovieModel.fromMap(item));
    }
    return favourites;
  }
}
