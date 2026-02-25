import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchedMovieShimmer extends StatelessWidget {
  const SearchedMovieShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade700,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
        child: Row(
          children: [
            // Poster Placeholder
            Container(
              height: 130,
              width: 95,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title line 1
                  Container(
                    height: 16,
                    width: double.infinity,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 8),

                  // Title line 2
                  Container(
                    height: 16,
                    width: 150,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 12),

                  // Rating box
                  Container(
                    height: 28,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // Arrow Placeholder
            Container(
              height: 16,
              width: 16,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
