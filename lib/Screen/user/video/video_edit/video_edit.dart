import 'dart:async';

import 'package:brandly_01/Screen/user/video/video_edit/download_video.dart';
import 'package:brandly_01/widget/colorpicker.dart';
import 'package:brandly_01/my_flutter_app_icons.dart';
import 'package:brandly_01/provider/authprovider.dart';
import 'package:brandly_01/model/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:video_player/video_player.dart';

import '../../../../widget/bottomSheet.dart';
import '../../../../widget/frames.dart';
import '../../../../widget/show_frems.dart';

class Videoedit extends StatefulWidget {
  String? videourl;
  Videoedit({super.key, this.videourl});

  @override
  State<Videoedit> createState() => _VideoeditState();
}

class _VideoeditState extends State<Videoedit> {
  late VideoPlayerController _controller;
  // static var httpClient = HttpClient();

  double xPosition = 0;
  double yPosition = 0;
  var ft = Fonts();
  var fontweight;
  var fontstyle;
  var fontfamily;
  String url =
      "https://firebasestorage.googleapis.com/v0/b/try-brandl.appspot.com/o/video%2FUntitled%20(1).mp4?alt=media&token=d1acf612-ad31-4445-8dda-1af65cf7da73";
  String image =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuI523Y_fNtlpuhBkyKKNJMUvc1KXNQGQorg&usqp=CAU";
  bool isLoading = false;
  bool isLoad = false;
  int processPercentage = 0;
  late StreamSubscription _streamSubscription;
  static const EventChannel _channel = EventChannel('video_editor_progress');

  ScreenshotController screenshotController = ScreenshotController();
  @override
  void initState() {
    super.initState();
    if (widget.videourl != null) {
      setState(() {
        url = widget.videourl!;
      });
    }
    enablecontroller();
    super.initState();
    _enableEventReceiver();
    indexframe = 0;
    mycolor = Colors.white;
    Myheight = 36;
    top = 20;
    left = 158;
    right = 0;
    bottom = 0;

    text = 'xyz';
  }

  void enablecontroller() {
    isLoad = true;
    _controller = VideoPlayerController.network(url)
      ..setLooping(true)
      ..initialize().then((_) {
        _controller.play();
      });
    _controller.setLooping(false);
    isLoad = false;
  }

  void _enableEventReceiver() {
    _streamSubscription =
        _channel.receiveBroadcastStream().listen((dynamic event) {
      setState(() {
        processPercentage = (event.toDouble() * 100).round();
      });
    }, onError: (dynamic error) {
      print('Received error: ${error.message}');
    }, cancelOnError: true);
  }

  void _disableEventReceiver() {
    _streamSubscription.cancel();
  }

  Color mycolor = Colors.white;

  late double Myheight;
  late double top;
  late double left;
  late double right;
  late double bottom;

  String text = 'k';

  int indexframe = 0;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Myheight;
    });
    final ap = Provider.of<AuthProvider>(context);
    if (widget.videourl != null) {
      setState(() {
        url = widget.videourl!;
      });
    }

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
                // imgss(context);
              },
              icon: const Icon(Icons.download_rounded)),
          IconButton(onPressed: () {}, icon: const Icon(MyFlutterApp.chat_alt)),
        ],
      ),
      body: isLoad
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(children: [
                FramesWidget(onFrameSelected: _updateIndexframe),
                const SizedBox(height: 70),
                Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.width,
                            width: MediaQuery.of(context).size.width,
                            child: VideoPlayer(_controller)),
                        Screenshot(
                          controller: screenshotController,
                          child: Stack(
                            children: [
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
                      ],
                    ),
                    Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                _showColorPicker();
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
                                setState(() {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                });
                              },
                              icon: const Icon(Icons.tab)),
                          IconButton(
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                await downloadvideo(screenshotController, url);
                                setState(() {
                                  isLoading = false;
                                });
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

  void updateFont(index) {
    setState(() {
      fontfamily = ft.fonts[index]["fontfamily"].toString();
      fontweight = ft.fonts[index]["fontweight"] as FontWeight?;
      fontstyle = ft.fonts[index]["fontstyle"] as FontStyle?;
    });
  }

  Future<void> _showColorPicker() async {
    Color? selectedColor = await showColorPickerDialog(context, mycolor);
    if (selectedColor != null) {
      setState(() {
        mycolor = selectedColor;
      });
    }
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

  void _updateIndexframe(int newIndexframe) {
    setState(() {
      indexframe = newIndexframe;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _disableEventReceiver();
  }
}
