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
    this.borderwidth = 0.3,
  });
  final String movieImage;
  final double? height;
  final double? width;
  final double topRightRadius;
  final double bottomRightRadius;
  final double borderwidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(topRightRadius),
          bottomLeft: Radius.circular(6),
          topLeft: Radius.circular(6),
          bottomRight: Radius.circular(bottomRightRadius),
        ),
        border: Border.all(
          color: Colors.grey.shade100.withAlpha(80),
          width: borderwidth,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
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
                errorBuilder: (BuildContext, Object, StackTrace) {
                  return SizedBox(
                    height: height,
                    width: width,
                    child: Icon(Icons.image_not_supported_rounded),
                  );
                },
              ),
      ),
    );
  }
}
