import 'package:flutter/material.dart';
import 'package:quotesapp/widgets/dart//Mybutton.dart';
class DialogBox extends StatelessWidget {
  final controller;
  final onSave;
  final onCancel;
   DialogBox({
    super.key,
    required this.controller,
     required this.onSave,
     required this.onCancel
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple.shade50,
      content: Container(

        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //user input
             TextField(
              controller: controller ,
decoration: const InputDecoration(
  border: OutlineInputBorder(),
        hintText: 'Add new task',
),
            ),
      //buttons-> save+cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:<Widget> [
                Mybutton(text: 'Save',
                    onPressed: onSave),
               const SizedBox(width: 4),
                Mybutton(text: 'Cancel',
                    onPressed: onCancel)
                ],
            ),
          ],
        ),
      ),
    );
  }
}
