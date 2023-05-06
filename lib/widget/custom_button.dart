import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor:
            MaterialStateProperty.all<Color>(Colors.amber.shade500),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
            fontSize: 20,
            letterSpacing: 2,
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
