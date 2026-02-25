import 'package:flutter/material.dart';
import 'package:movies_app/constant.dart';

class NoConnectionBody extends StatelessWidget {
  const NoConnectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_tethering_error_rounded_outlined,
            size: 72,
            color: kTextColor,
          ),
          SizedBox(height: 8),
          Text(
            'There was an error ',
            style: TextStyle(
              fontSize: 16,
              color: kTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Please check your connection ! ',
            style: TextStyle(
              fontSize: 16,
              color: kTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
