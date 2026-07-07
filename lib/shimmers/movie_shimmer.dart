import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MovieShimmer extends StatelessWidget {
  const MovieShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white70.withAlpha(25),
      highlightColor: Colors.white70.withAlpha(50),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        // height: 150,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 244, 241, 241),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
