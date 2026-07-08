import 'package:flutter/material.dart';
import 'package:movies_app/constant.dart';

class HorizintalLine extends StatelessWidget {
  const HorizintalLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.8,
      margin: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: kTextColor.withAlpha(140),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
