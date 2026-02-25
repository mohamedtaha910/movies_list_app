import 'package:flutter/material.dart';
import 'package:movies_app/constant.dart';
import 'package:shimmer/shimmer.dart';

class MovieShimmer extends StatelessWidget {
  const MovieShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kTextColor.withAlpha(150),
      highlightColor: const Color.fromARGB(255, 120, 114, 114),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: 150,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 244, 241, 241),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
