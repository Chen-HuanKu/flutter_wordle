import 'package:flutter/material.dart';
import 'package:wordle/LetterBlock.dart';
import 'package:wordle/keyboard_letter_block.dart';

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
              30,
              (index) => const letterBlock(
                backgroundColor: Colors.transparent,
                letter: "",
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
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              9,
              (index) =>  keyboard_letter_block(
                letter: row3[index],
                backgroundColor: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}

final row1 = ["Q","W","E","R","T","Y","U","I","O","P"];
final row2 = ["A","S","D","F","G","H","J","K","L"];
final row3 = ["ENTER","Z","X","C","V","B","N","M","⌦"];