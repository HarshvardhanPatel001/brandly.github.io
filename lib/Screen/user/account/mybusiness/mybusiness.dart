import 'package:brandly_01/provider/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../information/register_business.dart';

class MyBusiness extends StatefulWidget {
  const MyBusiness({super.key});

  @override
  State<MyBusiness> createState() => _MyBusinessState();
}

class _MyBusinessState extends State<MyBusiness> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: true);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   ap.bussiness.clear();
    //   ap.getBusinessDataFromFirestore();
    //   ap.bussiness;
    // });
    return Scaffold(
      backgroundColor: const Color.fromARGB(73, 69, 63, 76),
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
        title: const Text("My Business"),
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          primary: false,
          itemCount: ap.bussiness.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 8, left: 8, top: 8, bottom: 8),
                              width: MediaQuery.of(context).size.width / 5.485,
                              height:
                                  MediaQuery.of(context).size.height / 11.973,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  color: Colors.blue.shade200,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          ap.bussiness[index].companylogo
                                          // ap.businessModel.companylogo
                                          ),
                                      fit: BoxFit.cover)),
                            ),
                            const SizedBox(width: 6),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.953,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5.0),
                                  Text(
                                    ap.bussiness[index].companyname,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 6.0),
                                  Text(
                                    ap.userModel.phoneNumber,
                                    style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(height: 6.0),
                                  Text(
                                    ap.bussiness[index].companyadress,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 20)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            color: Colors.amber.shade400,
                            fontSize: 14,
                          ),
                        )),
                  ),
                ]),
                const Divider(color: Colors.white70)
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber.shade700,
        onPressed: (() {
          print("object");
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const RegisterBusiness(),
          ));
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
