import 'dart:io';

import 'package:brandly_01/Screen/nav/bottomnavigation.dart';
import 'package:brandly_01/model/business_model.dart';
import 'package:brandly_01/provider/authprovider.dart';
import 'package:brandly_01/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:brandly_01/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../widget/text_form_fild.dart';

class RegisterBusiness extends StatefulWidget {
  const RegisterBusiness({super.key});

  @override
  State<RegisterBusiness> createState() => _RegisterBusinessState();
}

class _RegisterBusinessState extends State<RegisterBusiness> {
  File? image;
  final companynameController = TextEditingController();
  final companyemailController = TextEditingController();
  final companywebController = TextEditingController();
  final companyaddressController = TextEditingController();
  final companydescriptionController = TextEditingController();
  // final bioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    companynameController.dispose();
    companyemailController.dispose();
    companywebController.dispose();
    companyaddressController.dispose();
    companydescriptionController.dispose();
    // bioController.dispose();
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
                                hintText: "Enter Company Name",
                                labelText: "Enter Company Name",
                                inputType: TextInputType.name,
                                maxLines: 1,
                                controller: companynameController,
                              ),
                              const SizedBox(height: 10),
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
                                hintText: "Enter Company Email Address",
                                labelText: "Enter Company Email Address",
                                inputType: TextInputType.emailAddress,
                                maxLines: 1,
                                controller: companyemailController,
                              ),
                              const SizedBox(height: 10),

                              // website
                              textFeld(
                                hintText: "Enter Company Website (Optional)",
                                labelText: "Enter Company Website (Optional)",
                                inputType: TextInputType.url,
                                maxLines: 1,
                                controller: companywebController,
                              ),
                              const SizedBox(height: 10),

                              // address
                              textFeld(
                                validator: (name) {
                                  if (name == null || name.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                hintText: "Enter Company Address",
                                labelText: "Enter Company Address",
                                inputType: TextInputType.multiline,
                                maxLines: 3,
                                // minLines: 1,
                                controller: companyaddressController,
                              ),
                              const SizedBox(height: 10),

                              // Description
                              textFeld(
                                hintText:
                                    "Enter Company Description (Optional)",
                                labelText:
                                    "Enter Company Description (Optional)",
                                inputType: TextInputType.multiline,
                                maxLines: 3,
                                minLines: 1,
                                controller: companydescriptionController,
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

  // store bussiness data to database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    BusinessModel businessModel = BusinessModel(
      companyname: companynameController.text.trim(),
      companyadress: companyaddressController.text.trim(),
      companyemail: companyemailController.text.trim(),
      companydescription: companydescriptionController.text.trim(),
      companyweb: companywebController.text.trim(),
      companylogo: '',
      createdAt: '',
      uid: '',
    );

    if (image != null && _formKey.currentState!.validate()) {
      ap.saveBusinessDataToFirebase(
        context: context,
        businessModel: businessModel,
        businesslogo: image!,
        onSuccess: () {
          ap.saveBusinessUserDataToSP().then(((value) =>
              // ap.getBusinessDataFromFirestore()
              // .then(
              // (value) =>
              ap.setSignIn().then(
                    // (value) => ap.getBusinessDataFromFirestore().then(
                    (value) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Navigation(),
                        ),
                        (route) => false),
                    // ),
                    // ),
                  )));
        },
      );
    } else {
      if (image == null) {
        showSnackBar(context, "Please upload your Business logo");
      }
      if (_formKey.currentState!.validate() != null) {
        showSnackBar(context, "Please Fill the form");
      }
    }
  }
}
