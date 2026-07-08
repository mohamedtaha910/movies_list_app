import 'package:flutter/material.dart';
import 'package:movies_app/constant.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.categoryName});
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      // height: 10,
      // width: 10,
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white70.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(
        //   color: Colors.grey.shade100.withAlpha(50),
        //   width: 0.3,
        // ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              categoryName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: kTextColor,
              ),
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, color: kTextColor, size: 12),
        ],
      ),
    );
  }
}
