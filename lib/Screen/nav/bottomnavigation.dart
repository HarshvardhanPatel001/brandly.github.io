import 'package:brandly_01/Screen/user/home/home.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import '../user/video/Videopage.dart';
import '../user/account/account.dart';
import '../user/greeting.dart';
import '../user/my_business.dart';
import '../user/video/video_edit/video.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  Widget? _child;

  @override
  void initState() {
    _child = const HomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _child,
      bottomNavigationBar: FluidNavBar(
        icons: [
          FluidNavBarIcon(
              icon: Icons.home,
              backgroundColor: Colors.pink,
              extras: {"label": "home"}),
          FluidNavBarIcon(
              icon: Icons.movie_creation_outlined,
              backgroundColor: Colors.pink,
              extras: {"label": "Video"}),
          FluidNavBarIcon(
              icon: Icons.square_outlined,
              backgroundColor: Colors.pink,
              extras: {"label": "Brandly"}),
          FluidNavBarIcon(
              icon: Icons.square_outlined,
              backgroundColor: Colors.pink,
              extras: {"label": "Greting"}),
          FluidNavBarIcon(
              icon: Icons.person_outline_rounded,
              backgroundColor: Colors.pink,
              extras: {"label": "Profile"}),
        ],
        onChange: _handleNavigationChange,
        style: const FluidNavBarStyle(
            iconSelectedForegroundColor: Colors.white,
            iconUnselectedForegroundColor: Colors.white60),
        scaleFactor: 1.5,
        defaultIndex: 0,
        itemBuilder: (icon, item) => Semantics(
          label: icon.extras!["label"],
          child: item,
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = const HomeScreen();
          break;
        case 1:
          // _child = const VideoPage();
          _child = Video();
          break;
        case 2:
          _child = const MyBusinessPage();
          break;
        case 3:
          _child = const GreetingPage();
          break;
        case 4:
          _child = const AccountPage();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: const Duration(milliseconds: 200),
        child: _child,
      );
    });
  }
}
