import 'package:flutter/material.dart';
import 'package:movies_app/constant.dart';

class ProfileRow extends StatelessWidget {
  const ProfileRow({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
    required this.iconColor,
  });
  final void Function()? onTap;
  final String title;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              color: kTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(flex: 10),
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(50),
              // border: Border.all(color: Colors.grey.withAlpha(25), width: 0.5),
            ),
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: kTextColor,
              size: 14,
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
