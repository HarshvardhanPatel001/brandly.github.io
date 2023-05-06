import 'dart:io';

import 'package:brandly_01/Screen/information/register_business.dart';
import 'package:brandly_01/provider/authprovider.dart';
import 'package:brandly_01/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:brandly_01/model/user_model.dart';
import 'package:brandly_01/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../widget/text_form_fild.dart';

class UserInfromationScreen extends StatefulWidget {
  const UserInfromationScreen({super.key});

  @override
  State<UserInfromationScreen> createState() => _UserInfromationScreenState();
}

class _UserInfromationScreenState extends State<UserInfromationScreen> {
  File? image;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    bioController.dispose();
  }

  // for selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      backgroundColor: const Color.fromARGB(73, 69, 63, 76),
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              )
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
                child: Center(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => selectImage(),
                        child: image == null
                            ? const CircleAvatar(
                                backgroundColor: Colors.purple,
                                radius: 50,
                                foregroundImage:
                                    AssetImage('assets/person.png'),
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(image!),
                                radius: 50,
                              ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        margin: const EdgeInsets.only(top: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // name field
                              textFeld(
                                validator: (name) {
                                  if (name == null || name.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                labelText: "Enter Your Name",
                                hintText: "HArshil Chovatiya",
                                icon: Icons.account_circle,
                                inputType: TextInputType.name,
                                maxLines: 1,
                                controller: nameController,
                              ),

                              // email
                              textFeld(
                                validator: (email) {
                                  if (email == null || email.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (!RegExp(
                                          r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                      .hasMatch(email)) {
                                    return 'Enter valid Email';
                                  }
                                  return null;
                                },
                                labelText: "Enter Your Email",
                                icon: Icons.email,
                                inputType: TextInputType.emailAddress,
                                maxLines: 1,
                                controller: emailController,
                                hintText: 'abc@gmail.com',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: CustomButton(
                          text: "Continue",
                          onPressed: () => storeData(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  // Widget textFeld({
  //   String? labelText,
  //   String? hintText,
  //   String? Function(String?)? validator,
  //   required IconData icon,
  //   required TextInputType inputType,
  //   required int maxLines,
  //   required TextEditingController controller,
  // }) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 10),
  //     child: TextFormField(
  //       style: const TextStyle(color: Colors.white70),
  //       cursorColor: Colors.amber,
  //       controller: controller,
  //       validator: validator,
  //       keyboardType: inputType,
  //       maxLines: maxLines,
  //       decoration: InputDecoration(
  //         prefixIcon: Container(
  //           margin: const EdgeInsets.all(8.0),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(8),
  //             color: Colors.amber.shade600,
  //           ),
  //           child: Icon(
  //             icon,
  //             size: 20,
  //             color: Colors.white,
  //           ),
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //           borderSide: const BorderSide(
  //             color: Colors.white70,
  //           ),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //           borderSide: BorderSide(
  //             color: Colors.amber.shade600,
  //           ),
  //         ),
  //         labelText: labelText,
  //         hintText: hintText,
  //         hintStyle: const TextStyle(color: Colors.white70),
  //         labelStyle: TextStyle(
  //             color: Colors.amber.shade600, fontWeight: FontWeight.bold),
  //         alignLabelWithHint: true,
  //         border: const OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(8)),
  //         ),
  //         // border: InputBorder.none,
  //         fillColor: Colors.transparent,
  //         filled: true,
  //       ),
  //     ),
  //   );
  // }

  // store user data to database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      // bio: bioController.text.trim(),
      profilePic: "",
      createdAt: "",
      phoneNumber: "",
      uid: "",
    );
    if (image != null && _formKey.currentState!.validate()) {
      ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        profilePic: image!,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                // (value) => ap.setSignIn().then(
                (value) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterBusiness(),
                    ),
                    (route) => false),
                // ),
              );
        },
      );
    } else {
      if (image == null) {
        showSnackBar(context, "Please upload your profile photo");
      }
      if (_formKey.currentState!.validate() != null) {
        showSnackBar(context, "Please Fill the form");
      }
    }
  }
}
