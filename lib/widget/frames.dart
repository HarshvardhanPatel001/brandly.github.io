
  import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/authprovider.dart';
  getcustomframes(index,context) {
    switch (index) {
      case 0:
        return frames1(context);
      case 1:
        return frames2();
      case 2:
        return frames1(context);
      case 3:
        return frames1(context);
    }
  }
Widget frames1(context) {
    var ap = Provider.of<AuthProvider>(context);

    return Stack(
      children: [
        Container(
            child: Image.asset(
          "assets/framess.png",
          fit: BoxFit.contain,
        )),
        Positioned(
            bottom: MediaQuery.of(context).size.height * 0.03,
            left: MediaQuery.of(context).size.width * 0.14,
            child: Text(
              ap.bussiness[0].companyadress,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            )),
        Positioned(
            bottom: MediaQuery.of(context).size.height * 0.005,
            left: MediaQuery.of(context).size.width * 0.1,
            child: Text(
              ap.bussiness[0].companyemail,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            )),
        Positioned(
            bottom: MediaQuery.of(context).size.height * 0.005,
            left: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              ap.bussiness[0].companyweb,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            )),
        Positioned(
            bottom: MediaQuery.of(context).size.height * 0.052,
            right: MediaQuery.of(context).size.width * 0.04,
            child: Text(
              ap.userModel.phoneNumber,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            )),
      ],
    );
  }

  Widget frames2() {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Image.asset(
          "assets/frame.png",
          fit: BoxFit.contain,
        ),
      ],
    );
  }
