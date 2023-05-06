import 'dart:io';

import 'package:brandly_01/provider/authprovider.dart';
import 'package:brandly_01/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditName extends StatefulWidget {
  String profilepic;
  String name;
  EditName({super.key, required this.profilepic, required this.name});
  @override
  State<EditName> createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  File? image;
  TextEditingController usernameController = TextEditingController();

  // usernameController.text = "df";
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    name();
  }

  void name() {
    setState(() {
      usernameController.text = widget.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context);
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );

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
          title: const Text("Edit Profile"),
          actions: [
            TextButton(
              style: style,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await ap.EditName(usernameController.text.trim());
                }
                image == null
                    ? print("object")
                    : await ap.EditProfilePic(image!);
                await ap.getDataFromFirestore();
                await ap.saveUserDataToSP();
                Navigator.pop(context);
              },
              child: Text(
                "Save",
                style: TextStyle(color: Colors.amber.shade600, fontSize: 18),
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
        ),
        body: Center(
            child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => selectImage(),
                    child: image == null
                        ? CircleAvatar(
                            backgroundColor: Colors.purple,
                            radius: 60,
                            foregroundImage: NetworkImage(widget.profilepic),
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(image!),
                            radius: 50,
                          ),
                  ),
                  // CircleAvatar(
                  //   backgroundColor: Colors.purple,
                  //   radius: 60,
                  //   foregroundImage: NetworkImage(widget.profilepic),
                  // ),
                ],
              ),
              const SizedBox(height: 28),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 24.4,
                    vertical: MediaQuery.of(context).size.height / 69.86),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white70),
                  cursorColor: Colors.amber,
                  controller: usernameController,
                  onChanged: ((value) {
                    setState(() {
                      usernameController.text.trim();
                    });
                  }),
                  validator: (name) {
                    if (name == null || name.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  // initialValue: ap.userModel.name,
                  keyboardType: TextInputType.name,
                  minLines: 1,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.white70,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.amber.shade600,
                      ),
                    ),
                    labelText: "Enter Your Name",
                    hintText: "Enter Your Name",
                    hintStyle: const TextStyle(color: Colors.white70),
                    labelStyle: TextStyle(
                        color: Colors.amber.shade600,
                        fontWeight: FontWeight.bold),
                    alignLabelWithHint: true,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    fillColor: Colors.transparent,
                    filled: true,
                  ),
                ),
              ),
              // textFeld(

              //   // initialValue: 'ap.userModel.name',
              //   hintText: "Enter Your Name",
              //   labelText: "Enter Your Name",
              //   inputType: TextInputType.name,
              //   maxLines: 1,
              //   controller: usernameController,
              // ),
            ],
          ),
        )),
      ),
    );
  }
}
