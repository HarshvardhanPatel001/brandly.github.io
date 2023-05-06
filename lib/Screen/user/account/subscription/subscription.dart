import 'package:brandly_01/Screen/user/account/subscription/slider/subscription_slider.dart';
import 'package:flutter/material.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(236, 22, 22, 23),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
            ),
          ),
          title: const Text("Subscription"),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5.12,
                  height: MediaQuery.of(context).size.height / 8.109,
                ),
                const Text(
                  "Pacage Ending Date",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SubscriptionSlider(),
          ],
        ),
      ),
    );
  }
}
