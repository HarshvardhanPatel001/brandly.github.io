import 'package:brandly_01/widget/getdata.dart';
import 'package:flutter/material.dart';

import '../model/frame/frame_model.dart';

class FramesWidget extends StatefulWidget {
  final void Function(int) onFrameSelected; // add a callback function

  // int indexframe;
  const FramesWidget({Key? key, required this.onFrameSelected})
      : super(key: key);

  @override
  _FramesWidgetState createState() => _FramesWidgetState();
}

class _FramesWidgetState extends State<FramesWidget> {
  int _indexframe = 0; // initialize indexframe here

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<List<FramesModel>>(
          stream: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Stack(children: [
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      primary: false,
                      itemBuilder: (_, index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                _indexframe = index;
                                // widget.indexframe = index; // use setState here
                                // print(widget.indexframe);
                              });
                              widget.onFrameSelected(_indexframe);
                            },
                            child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      snapshot.data![index].farmeimg,
                                      height: 108,
                                      width: 92,
                                      fit: BoxFit.fitHeight,
                                    ))),
                          )),
                ),
              ]);
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
