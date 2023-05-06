
  // Uint8List imageBitmap =
    //     (await NetworkAssetBundle(Uri.parse(image)).load(image))
    //         .buffer
    //         .asUint8List();

    // final imageBitmap = (await rootBundle.load(imgpath)).buffer.asUint8List();

    // try {
    //   final tapiocaBalls = [
    //     // TapiocaBall.filter(Filters.pink, 0.2),
    //     TapiocaBall.imageOverlay(uint8list, 0, 0),
    //     // TapiocaBall.textOverlay(
    //     //     text, x.ceil(), y.ceil(), hight.toInt(), mycolor),
    //   ];
    //   print("will start");

    //   var request = await httpClient.getUrl(Uri.parse(url));
    //   var response = await request.close();
    //   var bytes = await consolidateHttpClientResponseBytes(response);
    //   String dir = (await getApplicationDocumentsDirectory()).path;
    //   File file = File('$dir/output.mp4');
    //   await file.writeAsBytes(bytes);
    //   print("file.......$file}");

    //   final cup = Cup(Content(file.path), tapiocaBalls);
    //   cup.suckUp(path).then((_) async {
    //     print("finished");
    //     setState(() {
    //       processPercentage = 0;
    //     });
    //     print(path);
    //     GallerySaver.saveVideo(path).then((bool? success) {
    //       print(success.toString());
    //     });

    //     setState(() {
    //       isLoading = false;
    //     });
    //   }).catchError((e) {
    //     print('Got error: $e');
    //   });
    // } on PlatformException {
    //   print("error!!!!");
    // }