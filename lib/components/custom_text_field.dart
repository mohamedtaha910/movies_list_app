import 'package:flutter/material.dart';
import 'package:movies_app/constant.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.onChanged});

  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a search term';
        }
        return null;
      },
      // onChanged: onChanged,
      onChanged: onChanged,
      cursorColor: Color.fromARGB(255, 175, 99, 1),
      decoration: InputDecoration(
        hint: Text(
          'Search Movies',
          style: TextStyle(
            color: kTextColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        border: InputBorder.none,
      ),

      // decoration: const InputDecoration(
      //   focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(100.0)),
      //     borderSide: BorderSide(color : Color.fromARGB(255, 175, 99, 1), width: 1.5),
      //   ),
      //   enabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(100.0)),
      //     borderSide: BorderSide(color: kTextColor, width: 1.5),
      //   ),
      //   hintText: 'Search Movies',
      //   hintStyle: TextStyle(color: kTextColor),
      //   border: OutlineInputBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(100.0)),
      //   ),
      // ),
    );
  }
}
