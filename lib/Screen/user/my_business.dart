import 'package:flutter/material.dart';


class MyBusinessPage extends StatefulWidget {
  const MyBusinessPage({super.key});

  @override
  State<MyBusinessPage> createState() => _MyBusinessPageState();
}

class _MyBusinessPageState extends State<MyBusinessPage> {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(home: MyBusiness());
    return const Scaffold(backgroundColor: Color.fromARGB(249, 26, 25, 26),);
  }
}
