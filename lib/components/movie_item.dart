import 'package:flutter/material.dart';
// import 'package:movies_app/models/movie_model.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    super.key,
    required this.movieImage,
    this.height,
    this.width,
    this.topRightRadius = 6,
    this.bottomRightRadius = 6,
  });
  final String movieImage;
  final double? height;
  final double? width;
  final double topRightRadius;
  final double bottomRightRadius;

  @override
  Widget build(BuildContext context) {
    try {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(topRightRadius),
            bottomLeft: Radius.circular(6),
            topLeft: Radius.circular(6),
            bottomRight: Radius.circular(bottomRightRadius),
          ),
          border: Border.all(
            color: Colors.grey.shade100.withAlpha(100),
            width: 0.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(100),
              offset: Offset(-3, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(topRightRadius),
            bottomLeft: Radius.circular(6),
            topLeft: Radius.circular(6),
            bottomRight: Radius.circular(bottomRightRadius),
          ),
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
