import 'package:flutter/material.dart';

class keyboard_letter_block extends StatelessWidget {
  const keyboard_letter_block(
      {super.key,
      required this.letter,
      required this.backgroundColor,
      required this.onKeyPress});
  final String letter;
  final Color backgroundColor;
  final void Function() onKeyPress;

  @override
  Widget build(BuildContext context) {
    if (letter == "ENTER" || letter == "⌦") {
      return InkWell(
        onTap: () {
          onKeyPress();
        },
        child: Container(
          height: 48,
          width: 56,
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                letter,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
    } else if (letter == "⌦"){
      return InkWell(
        onTap: () {
          onKeyPress();
        },
        child: Container(
          height: 48,
          width: 56,
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                letter,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
    }else 
    {
      return InkWell(
        onTap: () {
          onKeyPress();
        },
        child: Container(
          height: 48,
          width: 30,
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                letter,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
