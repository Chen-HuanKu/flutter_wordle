import 'package:flutter/material.dart';
import 'package:wordle/LetterBlock.dart';
import 'package:wordle/keyboard_letter_block.dart';

const wordToGuess = "apple";

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
  String buffer = "";
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
              30,
              (index) => letterBlock(
                backgroundColor: Colors.transparent,
                letter: (index < buffer.length) ? buffer[index] : "",
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
                    if(index == 0){
                      //check if word exists
                      //if word is 5 letters
                      //if word = wordinlist 
                      //what letters match
                    }else if (index == 8){
                      buffer = buffer.substring(0, buffer.length - 1);
                    }else {
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

final row1 = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"];
final row2 = ["A", "S", "D", "F", "G", "H", "J", "K", "L"];
final row3 = ["ENTER", "Z", "X", "C", "V", "B", "N", "M", "⌦"];
