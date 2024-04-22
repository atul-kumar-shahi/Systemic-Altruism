import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required this.text, this.icon});

  final Function() onPressed;
  final String text;
  final IconData ?icon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: ElevatedButton.icon(
        icon: Icon(icon),
        clipBehavior: Clip.hardEdge,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 159, 132, 99)
        ),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(text,style: const TextStyle(
              fontFamily: 'LibreCaslon',
              fontWeight: FontWeight.w800,
              fontSize: 16,
            color: Colors.white
          ),
          ),
        ),
      ),
    );
  }
}
