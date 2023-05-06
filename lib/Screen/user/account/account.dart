// ignore_for_file: unused_element

import 'package:brandly_01/Screen/splash/splash.dart';
import 'package:brandly_01/Screen/user/account/mybusiness/mybusiness.dart';
import 'package:brandly_01/Screen/user/account/name/edit_name.dart';
import 'package:brandly_01/Screen/user/account/subscription/subscription.dart';
import 'package:brandly_01/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../provider/authprovider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    final ap = Provider.of<AuthProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ap.bussiness.clear();
      ap.getBusinessDataFromFirestore();
      ap.bussiness;
    });
    @override
    void initState() async {
      super.initState();
      await ap.getDataFromFirestore();
      await ap.saveUserDataToSP();
      // ap.bussiness.clear();

      // ap.getBusinessDataFromFirestore();
      // ap.bussiness;
    }

    String profilepic = ap.userModel.profilePic;
    String name = ap.userModel.name;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(236, 22, 22, 23),
        body: SafeArea(
          child: isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.amber[150],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      //User Account
                      GestureDetector(
                        onTap: () {
                          // print("click");
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => EditName(
                                      profilepic: profilepic,
                                      name: name,
                                    )),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.purple,
                                  radius: 30,
                                  foregroundImage: NetworkImage(profilepic),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ap.userModel.name.toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      ap.userModel.phoneNumber,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      //upgreed your plan
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Subscription()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue[400],
                          ),
                          height: 60,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Upgrade Your Plan",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Icon(
                                  MyFlutterApp.crown_1,
                                  color: Colors.amber,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      //manage my business
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MyBusiness()));
                        },
                        leading: const Icon(
                          MyFlutterApp.briefcase,
                          color: Colors.white,
                        ),
                        title: const Text(
                          "My Business",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        subtitle: const Text(
                          "Manage your business here",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      //My Post
                      ListTile(
                        leading: const Icon(
                          Icons.download_outlined,
                          color: Colors.white,
                        ),
                        title: const Text(
                          "My Post",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        subtitle: const Text(
                          "Your Downloaded Post",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        onTap: () {},
                      ),
                      // help & support
                      const ListTile(
                        leading: Icon(
                          MyFlutterApp.chat_alt,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Help & Support",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        subtitle: Text(
                          "Contact us for any Query",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      // Rate Us
                      const ListTile(
                        leading: Icon(
                          Icons.stars_outlined,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Rate Us",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        subtitle: Text(
                          "Rate Us on playstore",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      // Share Us
                      const ListTile(
                        leading: Icon(
                          MyFlutterApp.export_outline,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Share Us",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        subtitle: Text(
                          "Share to friend and family",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      // Privacy Policy
                      const ListTile(
                        leading: Icon(
                          MyFlutterApp.lock_alt,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Privacy Policy",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        subtitle: Text(
                          "Privacy Policy for application",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      // Terms & Services
                      const ListTile(
                        leading: Icon(
                          Icons.picture_as_pdf_sharp,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Terms & Services",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        subtitle: Text(
                          "Terms & Services for application",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      // Terms & Services
                      ListTile(
                        leading: const Icon(
                          MyFlutterApp.logout,
                          color: Colors.white,
                        ),
                        onTap: () async {
                          await ap.userSignOut().then(
                                (value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Splash(),
                                    ),
                                    (route) => false),
                              );
                          final SharedPreferences s =
                              await SharedPreferences.getInstance();
                          s.setBool("is_signedin", false);
                        },
                        title: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
