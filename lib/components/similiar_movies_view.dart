import 'package:flutter/material.dart';
import 'package:movies_app/components/movie_item.dart';
import 'package:movies_app/constant.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/screens/movie_details_page.dart';
import 'package:movies_app/services/movies_sevices.dart';

class SimiliarMoviesView extends StatelessWidget {
  const SimiliarMoviesView({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MoviesServices().getSimilarMovies(id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MovieModel> similiarMovies = snapshot.data!;
          return similiarMovies.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: const Text(
                      'There is No Similar movies !',
                      style: TextStyle(
                        fontSize: 14,
                        color: kTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      similiarMovies.length,
                      (index) => Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetails(
                                      id: similiarMovies[index].id,
                                    ),
                                  ),
                                );
                              },
                              child: MovieItem(
                                movieImage: similiarMovies[index].poster,
                                height: 150,
                                width: 100,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              similiarMovies[index].title.length >= 13
                                  ? ' ${similiarMovies[index].title.substring(0, 13)}...'
                                  : similiarMovies[index].title, //
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: kTextColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading similar movies'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
