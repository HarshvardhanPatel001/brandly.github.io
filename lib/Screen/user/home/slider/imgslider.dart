import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImgSlider extends StatefulWidget {
  const ImgSlider({Key? key}) : super(key: key);

  @override
  State<ImgSlider> createState() => _ImgSliderState();
}

class _ImgSliderState extends State<ImgSlider> {
  int currentIndex = 0;
  final CarouselController _controller = CarouselController();

  List<String> images = [
    "https://firebasestorage.googleapis.com/v0/b/ecom-57370.appspot.com/o/jn%20(3)%20(1).jpg?alt=media&token=d5b4d979-eb38-4425-9c59-4b9808cff186",
    "https://firebasestorage.googleapis.com/v0/b/ecom-57370.appspot.com/o/jn%20(3)%20(1).jpg?alt=media&token=d5b4d979-eb38-4425-9c59-4b9808cff186",
    "https://firebasestorage.googleapis.com/v0/b/ecom-57370.appspot.com/o/jn%20(3)%20(1).jpg?alt=media&token=d5b4d979-eb38-4425-9c59-4b9808cff186",
    "https://firebasestorage.googleapis.com/v0/b/ecom-57370.appspot.com/o/jn%20(3)%20(1).jpg?alt=media&token=d5b4d979-eb38-4425-9c59-4b9808cff186",
    "https://firebasestorage.googleapis.com/v0/b/ecom-57370.appspot.com/o/jn%20(3)%20(1).jpg?alt=media&token=d5b4d979-eb38-4425-9c59-4b9808cff186",
    "https://firebasestorage.googleapis.com/v0/b/ecom-57370.appspot.com/o/jn%20(3)%20(1).jpg?alt=media&token=d5b4d979-eb38-4425-9c59-4b9808cff186",
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _controller,
          items: images.map(
            (i) {
              return Builder(
                builder: (BuildContext context) => Image.network(
                  i,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              );
            },
          ).toList(),
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 1.0,
              height: MediaQuery.of(context).size.height / 4.192,
              viewportFraction: .95,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              }),
        ),
      ],
    );
  }
}
