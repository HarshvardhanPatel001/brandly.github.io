import 'package:brandly_01/widget/all_scr.dart';
import 'package:flutter/material.dart';

class AllScreen extends StatefulWidget {
  String name;
  AllScreen({super.key, required this.name});

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              widget.name,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: const Color.fromARGB(236, 22, 22, 23),
        body: Container(
          child: const AllScr(),
        ));
  }
}
