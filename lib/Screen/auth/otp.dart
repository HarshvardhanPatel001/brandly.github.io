import 'package:brandly_01/provider/authprovider.dart';
import 'package:brandly_01/widget/custom_button.dart';
import 'package:brandly_01/Screen/information/user_information_screen.dart';
import 'package:brandly_01/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../nav/bottomnavigation.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String phone;

  const OtpScreen(
      {super.key, required this.verificationId, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      backgroundColor: const Color.fromARGB(73, 69, 63, 76),
      body: SafeArea(
        child: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.amber[150],
                ),
              )
            : Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("OTP Verification",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.amber.shade400,
                          )),
                      const SizedBox(height: 10),
                      const Text(
                        "Enter the OTP send to your phone number",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Text(
                            "Edit",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              widget.phone,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.amber.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          "Enter OTP Code",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: 60,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.white70,
                            ),
                          ),
                          textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.amber),
                        ),
                        onCompleted: (value) {
                          setState(() {
                            otpCode = value;
                          });
                        },
                      ),
                      const SizedBox(height: 55),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: CustomButton(
                          text: "Verify".toUpperCase(),
                          onPressed: () {
                            if (otpCode != null) {
                              verifyOtp(context, otpCode!);
                            } else {
                              showSnackBar(context, "Enter 6-Digit code");
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Didn't receive any code?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Resend New Code",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  // verify otp
  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        // checking whether user exists in the db
        ap.checkExistingUser().then(
          (value) async {
            if (value == true) {
              // user exists in our app
              ap.getDataFromFirestore().then(
                    (value) => ap.saveUserDataToSP().then(
                          (value) => ap.setSignIn().then(
                                (value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Navigation(),
                                    ),
                                    (route) => false),
                              ),
                        ),
                  );
            } else {
              // new user
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserInfromationScreen()),
                  (route) => false);
            }
          },
        );
      },
    );
  }
}
