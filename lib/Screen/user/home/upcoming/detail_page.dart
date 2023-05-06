import 'package:flutter/material.dart';

class DaysDetailPage extends StatefulWidget {
  const DaysDetailPage({super.key});

  @override
  State<DaysDetailPage> createState() => _DaysDetailPageState();
}

class _DaysDetailPageState extends State<DaysDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: const Image(image: AssetImage("assets/splashlogo.png")));
  }
}
