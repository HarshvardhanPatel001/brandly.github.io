import 'package:flutter/material.dart';
import '../model/font.dart';

class SliderWidget extends StatefulWidget {
  final double initialFontSize;
  final Function(double) onFontSizeChanged;

  const SliderWidget({
    Key? key,
    required this.initialFontSize,
    required this.onFontSizeChanged,
  }) : super(key: key);

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _fontSize = 0.0;
  double _minFontSize = 18.0;

  @override
  void initState() {
    super.initState();
    _fontSize = widget.initialFontSize;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: const Color.fromARGB(249, 26, 25, 26),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              height: 100,
              color: const Color.fromARGB(249, 26, 25, 26),
              child: Card(
                color: const Color.fromARGB(249, 26, 25, 26),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'HEIGHT',
                      style: TextStyle(color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          _fontSize.round().toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: const Color(0xFF8D8E98),
                        thumbColor: Colors.white,
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 10),
                        overlayShape:
                            const RoundSliderOverlayShape(overlayRadius: 15.0),
                        overlayColor: const Color(0x29EB1555),
                        showValueIndicator: ShowValueIndicator.always,
                      ),
                      child: Slider(
                        value: _fontSize,
                        min: 0,
                        max: 100,
                        label: _getLabel(_fontSize),
                        onChanged: (newValue) {
                          if (newValue < 18) {
                            setState(() {
                              _fontSize = 18;
                            });
                          } else {
                            setState(() {
                              _fontSize = newValue;
                            });
                            widget.onFontSizeChanged(newValue);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getLabel(double value) {
    if (value < 18) {
      return '0';
    } else {
      return '${value.round()}';
    }
  }
}

var ft = Fonts();
bottomfontSheet(context, updateFont) {
  showModalBottomSheet(
      context: context,
      enableDrag: true,
      useRootNavigator: true,
      isScrollControlled: true,
      clipBehavior: Clip.antiAlias,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, state) {
            return Container(
              height: MediaQuery.of(context).size.height / 3,
              color: const Color.fromARGB(248, 42, 40, 42),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width / 5),
                        Column(
                          children: const [
                            Text(
                              "Select font style",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 28,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    color: const Color.fromARGB(248, 42, 40, 42),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 4 / 2,
                              mainAxisSpacing: 2),
                      itemCount: ft.fonts.length,

                      // physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            updateFont(index);

                            // setState(() {
                            //   fontfamily =
                            //       ft.fonts[index]["fontfamily"].toString();
                            //   fontweight = ft.fonts[index]["fontweight"]
                            //       as FontWeight?;
                            //   fontstyle =
                            //       ft.fonts[index]["fontstyle"] as FontStyle?;
                            // });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(12.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              border: Border.all(color: Colors.white),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                      8.0) //                 <--- border radius here
                                  ),
                            ),
                            child: Center(
                                child: Text(
                              "Brandly",
                              style: TextStyle(
                                  fontFamily:
                                      ft.fonts[index]["fontfamily"].toString(),
                                  fontStyle: ft.fonts[index]["fontstyle"]
                                      as FontStyle?,
                                  fontWeight: ft.fonts[index]["fontweight"]
                                      as FontWeight?,
                                  color: Colors.white),
                            )),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      });
}
