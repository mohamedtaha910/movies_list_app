import 'package:flutter/material.dart';
import 'package:movies_app/constant.dart';
// import 'package:movies_app/screens/trailer_screen.dart';

class TrailerButton extends StatelessWidget {
  const TrailerButton({super.key, required this.movieId,required this.onTap});
  final int movieId;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top:3 , left: 0),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
        decoration: BoxDecoration(
          // color: Colors.white70.withAlpha(25),
          color: kTextColor.withAlpha(50),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.play_arrow_rounded, color: kTextColor, size: 24),
            SizedBox(width: 6),
            Text(
              'Trailer',

              style: TextStyle(
                letterSpacing: 1.2,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
