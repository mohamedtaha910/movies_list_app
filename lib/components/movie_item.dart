
import 'package:flutter/material.dart';
// import 'package:movies_app/models/movie_model.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    super.key,
    required this.movieImage,
    this.height,
    this.width,
  });
  final String movieImage;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    try {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),

        child: movieImage.isEmpty
            ? Image.asset(
                'assets/poster.jpg',
                fit: BoxFit.cover,
                height: height,
                width: width,
              )
            : Image.network(
                'https://image.tmdb.org/t/p/w500$movieImage',
                fit: BoxFit.cover,
                height: height,
                width: width,
              ),
      );
    } on NetworkImageLoadException catch (e) {
      // log(e.toString());
      return Image.asset(
        'assets/poster.jpg',
        fit: BoxFit.cover,
        height: height,
        width: width,
      );
    } on Exception catch (e) {
      // log(e.toString());
      return Image.asset(
        'assets/poster.jpg',
        fit: BoxFit.cover,
        height: height,
        width: width,
      );
    }
  }
}
