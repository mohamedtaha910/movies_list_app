import 'package:flutter/material.dart';
import 'package:movies_app/constant.dart';
import 'package:movies_app/models/movie_details_model.dart';

class DetailsRow extends StatelessWidget {
  const DetailsRow({super.key, required this.movie});
  final MovieDetailsModel movie;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),

        Icon(Icons.date_range_outlined, size: 22, color: kTextColor.withAlpha(200)),
        const SizedBox(width: 8),
        SizedBox(
          // width: 50,
          child: Text(
            movie.releaseDate.length >= 4
                ? movie.releaseDate.substring(0, 4)
                : movie.releaseDate,
            style: TextStyle(
              fontSize: 16,
              color: kTextColor.withAlpha(200),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text('  |  ', style: TextStyle(fontSize: 22, color: kTextColor.withAlpha(200))),
        Icon(Icons.timer_outlined, size: 22, color: kTextColor.withAlpha(200)),
        const SizedBox(width: 8),
        SizedBox(
          // width: 70,
          child: Text(
            '${movie.runtime} min',
            style: TextStyle(
              fontSize: 16,
              color: kTextColor.withAlpha(200),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text('  |  ', style: TextStyle(fontSize: 22, color: kTextColor.withAlpha(200))),
        Icon(Icons.movie_creation_outlined, size: 22, color: kTextColor.withAlpha(200)),
        const SizedBox(width: 8),
        SizedBox(
          width: 90,
          child: Text(
            // textAlign: TextAlign.center,
            movie.genres.isNotEmpty ? movie.genres[0] : 'No genres',
            style: TextStyle(
              fontSize: 16,
              color: kTextColor.withAlpha(200),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        const Spacer(),
      ],
    );
  }
}
