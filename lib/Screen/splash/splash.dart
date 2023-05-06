import 'dart:async';
import 'package:brandly_01/Screen/auth/phlogin.dart';
import 'package:brandly_01/provider/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../nav/bottomnavigation.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool SignedIn = false;

  @override
  void initState() {
    // await super.initState();
    // requestPermission;
    twry();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SignedIn ? const Navigation() : const LoginScreen())));
  }

  twry() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    await ap.checkSign();
    await check();
    await getuser();
  }

  getuser() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    var check = ap.checkSign();
    print("obt.......${ap.isSignedIn}");
    if (ap.isSignedIn == true) {
      setState(() {
        SignedIn = true;
      });
      print("............hello.... ${ap.isSignedIn}");
    }
    // ap.bussiness.clear();
    // ap.getBusinessDataFromFirestore();
    // ap.getBusinessDataFromSP();
  }

  check() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.checkSign();
    print("............hello.... ${ap.isSignedIn}");
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    print(ap.isSignedIn);
    return Center(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(73, 69, 63, 76),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(73, 69, 63, 76),
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.394,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(image: AssetImage("assets/splashlogo.png"))
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4.65,
              ),
              CircularProgressIndicator(
                backgroundColor: const Color.fromARGB(175, 255, 236, 179),
                valueColor: AlwaysStoppedAnimation(Colors.amber.shade600),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Designed by JN Softech",
                style: TextStyle(color: Color.fromARGB(194, 255, 236, 179)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
