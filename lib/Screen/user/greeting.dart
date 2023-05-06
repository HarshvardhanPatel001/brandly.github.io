import 'package:flutter/material.dart';

import '../../mongo/conection.dart';

class GreetingPage extends StatefulWidget {
  const GreetingPage({super.key});

  @override
  State<GreetingPage> createState() => _GreetingPageState();
}

class _GreetingPageState extends State<GreetingPage> {
  String image =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8l5jWu38kDvGJUbU_Y4g3X6P9JLuw-u5tp6innKWp37_2P-qlBCxIJLuiciF82vAD-Mc&usqp=CAU";
  String video = "https://www.fluttercampus.com/video.mp4";
  double xPosition = 0;
  double yPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(249, 26, 25, 26),
        body: Center(
          child: TextButton(
            child: const Text("click"),
            onPressed: () async {
              // Mogodatabase.connect();
            },
          ),
        ));
  }
}
