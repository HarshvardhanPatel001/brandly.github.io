import 'package:brandly_01/provider/authprovider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNo = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;

  // void _submit() {
  //   final isValid = _formKey.currentState!.validate();
  //   if (!isValid) {
  //     return;
  //   }
  //   _formKey.currentState!.save();
  // }

  @override
  Widget build(BuildContext context) {
    _phoneNo.selection =
        TextSelection.fromPosition(TextPosition(offset: _phoneNo.text.length));
    final GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.amber.shade600;
    }

    return GestureDetector(
      onTap: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(73, 69, 63, 76),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 55),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Welcome back!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.amber.shade400,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Plesae provide your phone number to  \ncontinue",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  validator: (phone) {
                    if (phone == null || phone.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (phone.length != 10) {
                      return 'Enter Valid Phone Number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    prefixIcon: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 19, vertical: 14),
                      child: Text(
                        "(+91)",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(82, 227, 47, 47)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                  maxLength: 10,
                  controller: _phoneNo,
                ),
                const SizedBox(
                  height: 21,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: RawMaterialButton(
                      fillColor: Colors.amber.shade600,
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            isChecked == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                        if (_formKey.currentState!.validate() &&
                            isChecked == true) {
                          sendPhoneNumber();
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Continue'.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'By signing up you confirm that you accept the ',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 10,
                        ),
                        children: [
                          TextSpan(
                            text: 'Terms and \n Conditions',
                            style: TextStyle(
                              color: Colors.amber.shade600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launch(
                                    'https://www.example.com/terms-and-conditions');
                              },
                          ),
                          const TextSpan(
                            text: ' and ',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 10,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: Colors.amber.shade600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launch(
                                    'https://www.example.com/privacy-policy');
                              },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = _phoneNo.text.trim();
    ap.signInWithPhone(context, "+91$phoneNumber", _phoneNo.text);
  }
}
