import 'package:brandly_01/Screen/user/home/custom_image/custom_image.dart';
import 'package:brandly_01/my_flutter_app_icons.dart';
import 'package:brandly_01/provider/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'all_days/goodmorning.dart';
import 'slider/imgslider.dart';
import 'upcoming/upcoming_days.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );

    // @override
    // void initState() async {
    //   super.initState();
    //   ap.bussiness.clear();
    //   ap.getBusinessDataFromFirestore();
    //   ap.bussiness;
    // }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ap.bussiness.clear();
      ap.getBusinessDataFromFirestore();
      ap.bussiness;
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(249, 26, 25, 26),
        leading: Row(
          children: const [
            SizedBox(width: 15),
            Icon(
              MyFlutterApp.user_edit,
              size: 22,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            style: style,
            onPressed: () {},
            child: const Icon(MyFlutterApp.crown),
          ),
          TextButton(
            style: style,
            onPressed: () {},
            child: const Text('Action 2'),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(236, 22, 22, 23),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(height: 6),
              ImgSlider(),
              //  SizedBox(height: 12),
              CustomImageSection(),
              SizedBox(height: 12),
              UpComingDays(),
              GoodMorning(),
              GoodMorning(),
              GoodMorning(),

              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 58.0),
        child: FloatingActionButton(
          child: const Icon(Icons.chat),
          backgroundColor: const Color.fromARGB(255, 76, 170, 81),
          onPressed: () {
            String url = "https://wa.me/+919537192471/?text=Hello";
            launch(url);
          },
        ),
      ),
    );
  }
}
