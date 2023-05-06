import 'package:brandly_01/Screen/user/home/edit_frames/days_frames.dart';
import 'package:brandly_01/model/days/days_model.dart';
import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

import 'getdata.dart';

class AllScr extends StatefulWidget {
  const AllScr({super.key});

  @override
  State<AllScr> createState() => _AllScrState();
}

class _AllScrState extends State<AllScr> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: StreamBuilder<List<ProductModel>>(
          stream: getProductData(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return GridView.builder(
                primary: false,
                itemCount: snapshot.data!.length,
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.9),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditAllFrames(
                            img: snapshot.data![index].image,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Stack(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.network(
                              snapshot.data![index].image,
                              height: MediaQuery.of(context).size.height / 5.24,
                              width: MediaQuery.of(context).size.width / 2.299,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 4.085,
                                  height:
                                      MediaQuery.of(context).size.height / 52.4,
                                  alignment: Alignment.center,
                                  // margin:
                                  //     const EdgeInsets.only(right: 12, top: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(4),
                                          bottomLeft: Radius.circular(14)),
                                      color: Colors.amber.shade400),
                                  child: const Text(
                                    "01 March 2023",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ))),
                        ]),
                        const SizedBox(height: 5),
                        snapshot.data![index].title.length <= 12
                            ? Text(
                                snapshot.data![index].title,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(231, 255, 255, 255)),
                              )
                            : SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: TextScroll(
                                        snapshot.data![index].title,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                231, 255, 255, 255)),
                                        pauseBetween:
                                            const Duration(milliseconds: 500),
                                        velocity: const Velocity(
                                            pixelsPerSecond: Offset(30, 0)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  );
                },
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(width: 10),
                  Text("Loading..."),
                ],
              ),
            );
          }),
    );
  }

  
}
