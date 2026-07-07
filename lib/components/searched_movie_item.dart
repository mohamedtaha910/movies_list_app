import 'package:flutter/material.dart';
import 'package:movies_app/components/movie_item.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/screens/movie_details_page.dart';

class SearchedMovieItem extends StatelessWidget {
  const SearchedMovieItem({super.key, required this.movie});
  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => MovieDetails(id: movie.id)),
        );
      },
      child: Container(
        // margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          // color: Colors.white70.withAlpha(25),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade100.withAlpha(50),
            width: 0.4,
          ),
        ),
        // padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        margin: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Row(
          children: [
            MovieItem(
              movieImage: movie.poster,
              height: 150,
              width: 110,
              topRightRadius: 0,
              bottomRightRadius: 0,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    // margin: const EdgeInsets.all(5),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white.withAlpha(25),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.orangeAccent,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          movie.rate.toString().substring(0, 3),
                          style: const TextStyle(
                            fontSize: 12,
                            // color: kTextColor,
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(width: 2),
            Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white70),
          ],
        ),
      ),
    );
  }
}
