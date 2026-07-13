import 'package:flutter/material.dart';
import 'package:movies_app/constant.dart';
// import 'package:movies_app/screens/trailer_screen.dart';

class TrailerButton extends StatelessWidget {
  const TrailerButton({super.key, required this.movieId, required this.onTap});
  final int movieId;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // margin: EdgeInsets.only(top:3 , left: 0),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
        decoration: BoxDecoration(
          // color: Colors.white70.withAlpha(25),
          // color: kTextColor.withAlpha(50),
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(20),
          border: Border(
            top: BorderSide(color: Colors.white.withAlpha(90), width: 0.7),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.play_arrow_rounded, color: Colors.white, size: 24),
            SizedBox(width: 6),
            Text(
              'Trailer'.toUpperCase(),

              style: TextStyle(
                letterSpacing: 1.3,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                // color: kTextColor,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
