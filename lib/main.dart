import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wordle/LetterBlock.dart';
import 'package:wordle/correct_alert_dialog.dart';
import 'package:wordle/keyboard_letter_block.dart';
import 'guessing_words.dart';
import 'target_words.dart';

final random = Random();

var targetWord = target_words[random.nextInt(target_words.length)];
String buffer = "";
int currentWord = 1;
List<String> pastWords = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Wordle',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'WORDLE',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
      ),
      body: Column(
        children: [
          //grid and keyboard
          GridView.count(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
            crossAxisCount: 5,
            mainAxisSpacing: 15,
            crossAxisSpacing: 5,
            children: List.generate(
                  (pastWords.length),
                  (index) => letterBlock(
                    backgroundColor: (index < pastWords.length)
                        ? checkLetter(pastWords[index], index)
                        : Colors.transparent,
                    letter: (index < pastWords.length) ? pastWords[index] : "",
                    //if index < buffer then buffer[index] else
                  ),
                ) +
                List.generate(
                  5,
                  (index) => letterBlock(
                    backgroundColor: Colors.transparent,
                    letter: (index < buffer.length) ? buffer[index] : "",
                    //if index < buffer then buffer[index] else
                  ),
                ) +
                List.generate(
                  (25 - (pastWords.length)),
                  (index) => const letterBlock(
                    backgroundColor: Colors.transparent,
                    letter: "",
                    //if index < buffer then buffer[index] else
                  ),
                ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              10,
              (index) => keyboard_letter_block(
                letter: row1[index],
                backgroundColor: (pastWords.contains(row1[index]))? (targetWord.contains(row1[index]))? const Color(0xFF6ca965): Colors.black: const Color(0xFF787c7f),
                onKeyPress: () {
                  setState(() {
                    buffer = buffer + row1[index];
                  });
                },
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              9,
              (index) => keyboard_letter_block(
                letter: row2[index],
                backgroundColor: (pastWords.contains(row2[index]))? (targetWord.contains(row2[index]))? const Color(0xFF6ca965): Colors.black: const Color(0xFF787c7f),
                onKeyPress: () {
                  setState(() {
                    buffer = buffer + row2[index];
                  });
                },
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              9,
              (index) => keyboard_letter_block(
                letter: row3[index],
                backgroundColor: (pastWords.contains(row3[index]))? (targetWord.contains(row3[index]))? const Color(0xFF6ca965): Colors.black: const Color(0xFF787c7f),
                onKeyPress: () {
                  setState(() {
                    if (index == 0) {
                      onEnterTap(context);
                    } else if (index == 8) {
                      buffer = buffer.substring(0, buffer.length - 1);
                    } else {
                      buffer = buffer + row3[index];
                    }
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

void onEnterTap(context) {
  //check if word exists
  //if word is 5 letters
  //if word = wordinlist
  //what letters match

  if (buffer.length != 5) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Not enough letters",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
    );
  } else if (!guessing_words.contains(buffer)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$buffer is not word list $targetWord is the answer ",
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
    );
  } else if (buffer == targetWord) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Correct",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
    );
    List<String> word = buffer.split('');
    pastWords = pastWords + word;
    buffer = "";
    showDialog(context: context, builder: (_)=>const CorrectAlertDialog());

  } else {
    //word is in list check letters
    List<String> word = buffer.split('');
    pastWords = pastWords + word;
    currentWord++;
    buffer = "";
  }
}

Color checkLetter(String letter, int index) {

  index = index%5;

  List<String> targetWordSplit = targetWord.split('');
  if (targetWordSplit.contains(letter)) {
    if (targetWordSplit[index] == letter) {
      return const Color(0xFF6ca965);
    } else {
      return const Color(0xFFc8b653);
    }
  } else {
    return const Color(0xFF787c7f);
  }
}

final row1 = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"];
final row2 = ["A", "S", "D", "F", "G", "H", "J", "K", "L"];
final row3 = ["ENTER", "Z", "X", "C", "V", "B", "N", "M", "⌦"];
