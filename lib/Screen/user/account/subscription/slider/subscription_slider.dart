import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SubscriptionSlider extends StatefulWidget {
  const SubscriptionSlider({Key? key}) : super(key: key);

  @override
  State<SubscriptionSlider> createState() => _SubscriptionSliderState();
}

class _SubscriptionSliderState extends State<SubscriptionSlider> {
  int currentIndex = 0;
  final CarouselController _controller = CarouselController();

  List<String> images = [
    "https://firebasestorage.googleapis.com/v0/b/try-brandl.appspot.com/o/Subcripton%2Ffree.png?alt=media&token=0cb0d8f7-906f-401a-aa32-88f9ab18bca9",
    "https://firebasestorage.googleapis.com/v0/b/try-brandl.appspot.com/o/Subcripton%2F1%20month.png?alt=media&token=eaa17fb7-8b9c-4deb-b7cf-5f6d561aa284",
    "https://firebasestorage.googleapis.com/v0/b/try-brandl.appspot.com/o/Subcripton%2F3%20month.png?alt=media&token=06768055-52cd-45db-9ea9-eacbb75c67b3",
    "https://firebasestorage.googleapis.com/v0/b/try-brandl.appspot.com/o/Subcripton%2F6%20month.png?alt=media&token=0be96900-5c8a-4eb0-b8d9-9ca236fa720a",
    "https://firebasestorage.googleapis.com/v0/b/try-brandl.appspot.com/o/Subcripton%2Fone%20year%20plan.png?alt=media&token=10df12c8-7ef4-4e4f-935d-918c2998e33e",
    "https://firebasestorage.googleapis.com/v0/b/try-brandl.appspot.com/o/Subcripton%2Fbusness%20plan.png?alt=media&token=7858ec72-91fd-469c-994a-fe708ef5f30b",
    "https://firebasestorage.googleapis.com/v0/b/try-brandl.appspot.com/o/Subcripton%2Fpolitical%20plan.png?alt=media&token=7b798da0-e096-4055-b002-d6549521996a"
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
                builder: (BuildContext context) => GestureDetector(
                  onTap: (() {}),
                  child: Image.network(
                    i,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              );
            },
          ).toList(),
          options: CarouselOptions(
              // autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 1.0,
              height: MediaQuery.of(context).size.height / 1.524,
              enableInfiniteScroll: false,
              viewportFraction: .75,
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
