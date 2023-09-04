// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:todo/buttons.dart';

class CustomDialog extends StatelessWidget {
  final dynamic controller;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const CustomDialog({
    Key? key,
    required this.controller,
    required this.onCancel,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: SizedBox(
        height: 120,
        child: Column(  
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            // user input
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add a new task',
              ),
            ),

            // buttons => cancel and save
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
               children: [
                //cancel button
                CustomButton(text: 'Cancel', onPressed: onCancel,),
                
                const SizedBox(width: 10,),

                //save button
                CustomButton(text: 'Save', onPressed: onSave),
               ],
              ),
          ],
        ),
      ),
    );
  }
}
