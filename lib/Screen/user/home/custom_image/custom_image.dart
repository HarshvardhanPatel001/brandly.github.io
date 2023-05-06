import 'package:brandly_01/Screen/newedit/editcustom.dart';
import 'package:flutter/material.dart';

class CustomImageSection extends StatefulWidget {
  const CustomImageSection({super.key});

  @override
  State<CustomImageSection> createState() => _CustomImageSectionState();
}

class _CustomImageSectionState extends State<CustomImageSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 21.4,
              vertical: MediaQuery.of(context).size.height / 69.86),
          child: const Text(
            "Custom Image",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width / 32),
            GestureDetector(
              onTap: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditCustom()));
              }),
              child: Column(
                children: [
                  Image.asset('assets/text.png',
                      width: MediaQuery.of(context).size.width / 2.194),
                ],
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width / 32),
            Column(
              children: [
                Image.asset('assets/text_img.png',
                    width: MediaQuery.of(context).size.width / 2.194),
              ],
            ),
          ],
        )
      ],
    );
  }
}
