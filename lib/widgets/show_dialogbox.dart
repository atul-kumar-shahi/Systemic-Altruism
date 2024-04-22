import 'package:flutter/material.dart';

void showDialogBox(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Help Desk'),
      content: const Text(
        'To upload Image click on upload Icon in top-right corner and to see the Image click on the bottom right corner ',
        style: TextStyle(
          fontFamily: 'LibreCaslon'
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'))
      ],
    ),
  );
}
