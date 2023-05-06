import 'package:brandly_01/Screen/user/home/edit_frames/days_frames.dart';
import 'package:flutter/material.dart';
import '../../../../model/days/days_model.dart';
import '../../../../widget/getdata.dart';
import '../../../../widget/test_row.dart';

class GoodMorning extends StatefulWidget {
  const GoodMorning({super.key});

  @override
  State<GoodMorning> createState() => _GoodMorningState();
}

class _GoodMorningState extends State<GoodMorning> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8),
      child: Column(
        children: [
          TextRow(
            text: 'Good Morning',
            name: "Good Morning",
          ),
          StreamBuilder<List<ProductModel>>(
              stream: getProductData(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 7.105,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        primary: false,
                        itemBuilder: (_, index) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditAllFrames(
                                          img: snapshot.data![index].image)),
                                );
                              },
                              child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Stack(children: [
                                      Image.network(
                                        snapshot.data![index].image,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                7.105,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.42,
                                        fit: BoxFit.fitHeight,
                                      ),
                                      Positioned(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              209.6,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              48,
                                          child: Container(
                                              width: 34,
                                              height: 12,
                                              alignment: Alignment.center,
                                              // margin:
                                              //     const EdgeInsets.only(right: 12, top: 8),
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                  color: Colors.black54),
                                              child: const Text(
                                                "Free",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              ))),
                                    ]),
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
}
