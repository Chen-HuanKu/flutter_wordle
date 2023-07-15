import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wordle/LetterBlock.dart';
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
                    10,
                    (index) => letterBlock(
                      backgroundColor: (index < buffer.length)
                          ? checkLetter(buffer[index], index)
                          : Colors.transparent,
                      letter: (index < buffer.length) ? buffer[index] : "",
                      //if index < buffer then buffer[index] else
                    ),
                  ) +
                  List.generate(
                    10,
                    (index) => letterBlock(
                      backgroundColor: (index < buffer.length)
                          ? checkLetter(buffer[index], index)
                          : Colors.transparent,
                      letter: (index < buffer.length) ? buffer[index] : "",
                      //if index < buffer then buffer[index] else
                    ),
                  ) +
                  List.generate(
                    10,
                    (index) => letterBlock(
                      backgroundColor: (index < buffer.length)
                          ? checkLetter(buffer[index], index)
                          : Colors.transparent,
                      letter: (index < buffer.length) ? buffer[index] : "",
                      //if index < buffer then buffer[index] else
                    ),
                  )),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              10,
              (index) => keyboard_letter_block(
                letter: row1[index],
                backgroundColor: Colors.grey,
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
                backgroundColor: Colors.grey,
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
                backgroundColor: Colors.grey,
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
  int wordStart = 0;
  int wordEnd = 0;

  if (currentWord == 1) {
    wordStart = 0;
    wordEnd = 5;
  } else if (currentWord == 2) {
    wordStart = 5;
    wordEnd = 10;
  } else if (currentWord == 3) {
    wordStart = 10;
    wordEnd = 15;
  } else if (currentWord == 4) {
    wordStart = 15;
    wordEnd = 20;
  } else if (currentWord == 5) {
    wordStart = 20;
    wordEnd = 25;
  } else if (currentWord == 6) {
    wordStart = 25;
    wordEnd = 30;
  }

  if (buffer.substring(wordStart, wordEnd).length != 5) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Not enough letters",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
    );
  } else if (!guessing_words.contains(buffer.substring(wordStart, wordEnd))) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$buffer is not word list $targetWord is the answer ",
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
    );
  } else if (buffer.substring(wordStart, wordEnd) == targetWord) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Correct",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
    );
    currentWord++;
  } else {
    //word is in list check letters
    List<String> word = buffer.substring(wordStart, wordEnd).split('');
    pastWords.add(word.join());
    currentWord++;
  }
}

Color checkLetter(String letter, int index) {
  List<String> targetWordSplit = targetWord.split('');
  if (targetWordSplit.contains(letter)) {
    if (targetWordSplit[index] == letter) {
      return Colors.green;
    } else {
      return Colors.yellow;
    }
  } else {
    return Colors.grey;
  }
}

final row1 = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"];
final row2 = ["A", "S", "D", "F", "G", "H", "J", "K", "L"];
final row3 = ["ENTER", "Z", "X", "C", "V", "B", "N", "M", "⌦"];
