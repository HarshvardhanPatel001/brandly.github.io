import 'package:brandly_01/Screen/user/home/edit_frames/days_frames.dart';
import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../../../model/days/days_model.dart';
import '../../../../model/days/samlpe_data.dart';
import '../../../../widget/test_row.dart';

class UpComingDays extends StatefulWidget {
  const UpComingDays({super.key});

  @override
  State<UpComingDays> createState() => _UpComingDaysState();
}

class _UpComingDaysState extends State<UpComingDays> {
  String text = "gd";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8),
      child: Column(
        children: [
          TextRow(
            text: 'Upcoming Days',
            name: "Upcoming Days",
          ),
          StreamBuilder<List<ProductModel>>(
              stream: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 5.24,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        primary: false,
                        itemBuilder: (_, index) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EditAllFrames(
                                      img: snapshot.data![index].image,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width /
                                          38.4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(73, 69, 63, 76),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.5),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                snapshot.data![index].image,
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.fill,
                                              )
                                              // Image.asset(
                                              //   "assets/person.png",
                                              //   height: 100,
                                              //   // scale: 2,
                                              //   fit: BoxFit.contain,
                                              // ),
                                              ),
                                          const SizedBox(height: 8),
                                          snapshot.data![index].title.length <=
                                                  12
                                              ? Text(
                                                  snapshot.data![index].title,

                                                  // "Central Excise Day",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromARGB(
                                                          231, 255, 255, 255)),
                                                )
                                              : SizedBox(
                                                  width: 96,
                                                  child: Row(
                                                    children: [
                                                      Flexible(
                                                        child: TextScroll(
                                                          snapshot.data![index]
                                                              .title,

                                                          // 'This is the sample text for Flutter TextScroll widget.',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          231,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                          pauseBetween:
                                                              const Duration(
                                                                  milliseconds:
                                                                      500),
                                                          velocity:
                                                              const Velocity(
                                                                  pixelsPerSecond:
                                                                      Offset(30,
                                                                          0)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                          //
                                          const SizedBox(height: 6),
                                          const Text(
                                            "24 Feb 2022",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white70),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            )),
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
        ],
      ),
    );
  }

  Stream<List<ProductModel>> getData() async* {
    yield await Future.delayed(
      const Duration(milliseconds: 500),
      () => sampleData.map((e) => ProductModel.fromData(e)).toList(),
    );
  }
}
