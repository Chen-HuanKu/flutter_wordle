import 'package:flutter/material.dart';

class letterBlock extends StatelessWidget {
  const letterBlock({super.key, required this.letter, required this.backgroundColor});
  final String letter;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.grey),
      ),
      child: Center(
        child:  Text(
          letter,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}