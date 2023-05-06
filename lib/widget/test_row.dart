import 'package:flutter/material.dart';

import 'all_screen.dart';

class TextRow extends StatefulWidget {
  final String text;
   String name;
   TextRow({super.key,  required this.text,required this.name});

  @override
  State<TextRow> createState() => _TextRowState();
}

class _TextRowState extends State<TextRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text.toString(),
            style: const TextStyle(
                fontSize: 19, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          TextButton(
            onPressed: () {
                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                           AllScreen(name: widget.name,)),
                                );
            },
            child: const Text(
              "View All",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
