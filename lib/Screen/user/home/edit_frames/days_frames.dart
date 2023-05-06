import 'package:brandly_01/my_flutter_app_icons.dart';
import 'package:brandly_01/provider/authprovider.dart';
import 'package:brandly_01/model/font.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../video/video_edit/download_video.dart';
import '../../../../widget/bottomSheet.dart';
import '../../../../widget/colorpicker.dart';
import '../../../../widget/frames.dart';
import '../../../../widget/show_frems.dart';

// ignore: must_be_immutable
class EditAllFrames extends StatefulWidget {
  String img;
  EditAllFrames({super.key, required this.img});

  @override
  State<EditAllFrames> createState() => _EditAllFramesState();
}

class _EditAllFramesState extends State<EditAllFrames> {
  Color mycolor = Colors.white;
  var indexframe;
  late double Myheight;
  late double top;
  late double left;
  late double right;
  late double bottom;
  String text = 'k';
  var ft = Fonts();
  var fontweight;
  var fontstyle;
  var fontfamily;

  @override
  void initState() {
    super.initState();
    indexframe = 0;
    mycolor = Colors.white;
    Myheight = 36;
    top = 15;
    left = 158;
    right = 0;
    bottom = 0;
  }

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Myheight;
    });
    final ap = Provider.of<AuthProvider>(context);
    setState(() {
      text = ap.bussiness[0].companyname;
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(249, 26, 25, 26),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(249, 26, 25, 26),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Edit Frame"),
        actions: [
          IconButton(
              onPressed: () {
                saveToGallery(context, screenshotController);
              },
              icon: const Icon(Icons.download_rounded)),
          IconButton(onPressed: () {}, icon: const Icon(MyFlutterApp.chat_alt)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          FramesWidget(onFrameSelected: _updateIndexframe),
          const SizedBox(height: 70),
          Column(
            children: [
              Screenshot(
                controller: screenshotController,
                child: Stack(
                  children: [
                    Image.network(widget.img,
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width),
                    getcustomframes(indexframe, context),
                    Positioned(
                      left: left,
                      top: top,
                      child: GestureDetector(
                        onPanUpdate: (dragUpdateDetails) {
                          setState(() {
                            left += dragUpdateDetails.delta.dx;
                            top += dragUpdateDetails.delta.dy;
                          });
                        },
                        child: Text(
                          text,
                          style: TextStyle(
                            color: mycolor,
                            fontSize: Myheight,
                            fontFamily: fontfamily,
                            fontStyle: fontstyle,
                            fontWeight: fontweight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          showColorPicker();
                        },
                        icon: const Icon(Icons.text_format)),
                    IconButton(
                        onPressed: () {
                          _showFontSizeDialog(context);
                          // bottomHeightSheet(context, Myheight, updateSize);
                        },
                        icon: const Icon(Icons.text_fields_rounded)),
                    IconButton(
                        onPressed: () {
                          bottomfontSheet(context, updateFont);
                        },
                        icon: const Icon(Icons.tab)),
                    IconButton(
                        onPressed: () {
                          saveToGallery(context, screenshotController);
                        },
                        icon: const Icon(Icons.download_rounded)),
                  ],
                ),
              )
            ],
          )
        ]),
      ),
    );
  }

  void _showFontSizeDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SliderWidget(
          initialFontSize: Myheight,
          onFontSizeChanged: (newFontSize) {
            setState(() {
              Myheight = newFontSize;
            });
          },
        );
      },
    );
  }

  void updateFont(index) {
    setState(() {
      fontfamily = ft.fonts[index]["fontfamily"].toString();
      fontweight = ft.fonts[index]["fontweight"] as FontWeight?;
      fontstyle = ft.fonts[index]["fontstyle"] as FontStyle?;
    });
  }

  Future<void> showColorPicker() async {
    Color? selectedColor = await showColorPickerDialog(context, mycolor);
    if (selectedColor != null) {
      setState(() {
        mycolor = selectedColor;
      });
    }
  }

  void _updateIndexframe(int newIndexframe) {
    setState(() {
      indexframe = newIndexframe;
    });
  }
}
