import 'dart:convert';
// import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/actor_model.dart';
import 'package:movies_app/models/cast_model.dart';
import 'package:movies_app/models/category_model.dart';
import 'package:movies_app/models/movie_details_model.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/models/video_model.dart';

class MoviesServices {
  static const String _apiKey = '181e02cab54525cc3256bfd16d5078cd';
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  /// Get popular movies
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List<MovieModel> movies = [];

      for (var movie in data['results']) {
        movies.add(MovieModel.fromJson(movie));
      }

      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  /// Search movies by name
  Future<List<MovieModel>> searchMovies(String movieName) async {

    final encodedQuery = Uri.encodeQueryComponent(movieName);

    final response = await http.get(
      Uri.parse('$_baseUrl/search/movie?api_key=$_apiKey&query=$encodedQuery'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List<MovieModel> movies = [];

      for (var movie in data['results']) {
        movies.add(MovieModel.fromJson(movie));
      }

      return movies;
    } else {
      throw Exception('Failed to search movies');
    }
  }

  /// Get movie details by ID
  Future<MovieDetailsModel> getMovieDetails(int id) async {
    
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/$id?api_key=$_apiKey'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return MovieDetailsModel.fromJson(data);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  /// Get movie cast
  Future<List<CastModel>> getMovieCast(int id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/$id/credits?api_key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List<CastModel> castList = [];

      for (var cast in data['cast']) {
        castList.add(CastModel.fromJson(cast));
      }

      return castList;
    } else {
      throw Exception('Failed to load movie cast');
    }
  }

  /// Get similar movies
  Future<List<MovieModel>> getSimilarMovies(int id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/$id/similar?api_key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List<MovieModel> movies = [];

      for (var movie in data['results']) {
        movies.add(MovieModel.fromJson(movie));
      }

      return movies;
    } else {
      throw Exception('Failed to load similar movies');
    }
  }

  /// Get actor movies
  Future<List<MovieModel>> getActorMovies(int personId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/person/$personId/movie_credits?api_key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<MovieModel> movies = [];

      for (var movie in data['cast']) {
        movies.add(MovieModel.fromJson(movie));
      }
      return movies;
    } else {
      throw Exception('Failed to load actor movies');
    }
  }

  /// get actor profile
  Future<ActorModel> getActorProfile(int personId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/person/$personId?api_key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ActorModel.fromJson(data);
    } else {
      throw Exception('Failed to load actor profile');
    }
  }

  /// Get favourite movies
  Future<List<MovieModel>> getFavouriteMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/upcoming?api_key=$_apiKey'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<MovieModel> movies = [];
      for (var movie in data['results']) {
        movies.add(MovieModel.fromJson(movie));
      }
      return movies;
    } else {
      throw Exception('Failed to load favourite movies');
    }
  }

  /// Get categories
  Future<List<CategoryModel>> getCategories() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/genre/movie/list?api_key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<CategoryModel> categories = [];
      for (var item in data['genres']) {
        categories.add(CategoryModel.fromJson(item));
      }
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  /// Get movies by category
  Future<List<MovieModel>> getMoviesByCategory(int id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/discover/movie?api_key=$_apiKey&with_genres=$id'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<MovieModel> movies = [];
      for (var movie in data['results']) {
        movies.add(MovieModel.fromJson(movie));
      }
      return movies;
    } else {
      throw Exception('Failed to load movies by category');
    }
  }

  /// Get movie videos
  Future<List<VideoModel>> getMovieVideos(int movieId) async {
  final response = await http.get(
    Uri.parse(
      '$_baseUrl/movie/$movieId/videos?api_key=$_apiKey',
    ),
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    List<VideoModel> videos = [];
    for(var video in data['results']) {
      videos.add(VideoModel.fromJson(video));
    }
    /// بنعمل فلتره للفيديوهات عشان نرجع التريلز بس 
    List<VideoModel> trailers = videos.where( (video)=> video.type == 'Trailer' && video.site == 'YouTube').toList();
    return trailers;
  } else {
    throw Exception('Failed to load videos');
  }
}


}
