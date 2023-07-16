import 'package:flutter/material.dart';

class CorrectAlertDialog extends StatelessWidget {
  const CorrectAlertDialog({super.key});


  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: const Text("Congratulations you got the word"),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close")),
        TextButton(onPressed: () {

        }, child: const Text("Play again"))
      ],
    );
  }
}