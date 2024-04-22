import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showSnackbar(BuildContext context,String text) {
  Flushbar(
    padding: const EdgeInsets.all(20),
    margin: EdgeInsets.all(10),
    isDismissible: true,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    flushbarPosition: FlushbarPosition.BOTTOM,
    message: text,
    messageSize: 15,
    borderRadius: BorderRadius.circular(12),
      backgroundColor: const Color.fromARGB(255, 159, 132, 99),
    duration: const Duration(seconds: 3),
    shouldIconPulse: true, // Make the icon pulsate
    flushbarStyle: FlushbarStyle.FLOATING, // Choose a style
  ).show(context);
}
