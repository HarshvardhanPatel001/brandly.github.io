import 'package:brandly_01/my_flutter_app_icons.dart';
import 'package:brandly_01/model/font.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import '../user/video/video_edit/download_video.dart';
import '../../widget/bottomSheet.dart';
import '../../widget/colorpicker.dart';
import '../../widget/frames.dart';
import '../../widget/show_frems.dart';

class EditCustom extends StatefulWidget {
  const EditCustom({super.key});

  @override
  State<EditCustom> createState() => _EditCustomState();
}

class _EditCustomState extends State<EditCustom> {
  Color mycolor = Colors.white;
  var indexframe;
  late double Myheight;
  late double top;
  late double left;
  late double right;
  late double bottom;
  late double width;
  late double height;
  String text = 'k';
  var ft = Fonts();
  var fontweight;
  var fontstyle;
  var fontfamily;
  final textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    indexframe = 0;
    mycolor = Colors.white;
    Myheight = 36;
    top = 20;
    left = 60;
    right = 0;
    bottom = 0;
    width = 200;
    height = 150;
    text = textEditingController.text.trim().toString();
  }

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Myheight;
    });
    // final ap = Provider.of<AuthProvider>(context);

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
        // Icon(Icons.arrow_back_ios_outlined),
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
                //

                child: Stack(
                  children: [
                    // Container(color: Colors.white),
                    Image.asset(
                      "assets/trrr.jpeg",
                      fit: BoxFit.contain,
                    ),
                    getcustomframes(indexframe, context),

                    Positioned(
                      top: top,
                      left: left,
                      child: Draggable(
                        feedback: Text(
                          text,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Myheight,
                            decoration: TextDecoration.none,
                            fontFamily: fontfamily,
                            fontStyle: fontstyle,
                            fontWeight: fontweight,
                          ),
                        ),
                        child: Container(
                          height: height,
                          width: width,
                          child: TextFormField(
                            cursorWidth: 2,
                            maxLines: 5,
                            controller: textEditingController,
                            onEditingComplete: () {
                              WidgetsBinding.instance.focusManager.primaryFocus
                                  ?.unfocus();
                            },
                            onChanged: (value) {
                              setState(() {
                                text = textEditingController.text.trim();
                              });
                            },
                            style: TextStyle(
                              color: mycolor,
                              fontSize: Myheight,
                              fontFamily: fontfamily,
                              fontStyle: fontstyle,
                              fontWeight: fontweight,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'type heare',
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        onDragEnd: (drag) {
                          final renderBox =
                              context.findRenderObject() as RenderBox;
                          Offset off = renderBox.globalToLocal(drag.offset);
                          setState(() {
                            top = (off.dy - 264) - (Myheight * .3);
                            left = off.dx;
                          });
                        },
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
