import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../utils/utils.dart';

downloadvideo(screenshotController, url) async {
  print("clicked!");
  final flutterFFmpeg = FlutterFFmpeg();
  var tempDir = await getTemporaryDirectory();

  var fileName = "${DateTime.now().microsecondsSinceEpoch}.png";
  String imgepath = "${tempDir.path}/$fileName";

  await screenshotController.captureAndSave(tempDir.path,
      fileName: fileName, pixelRatio: 9.0);

  final arguments = [
    '-i',
    url,
    '-i',
    imgepath,
    '-filter_complex',
    // '[0:v][1:v]overlay=0:0',
    '[1:v]scale=1200:1200[overlay];[0:v][overlay]overlay=0:0[v]',
    '-map',
    '[v]',
    '-c:a',
    'copy',
    // '-s',
    // '1920x1080',
    '/storage/emulated/0/Download/video000011.mp4'
  ];

  await flutterFFmpeg.executeWithArguments(arguments);

  try {
    final file = File(imgepath);
    if (await file.exists()) {
      await file.delete();
      print("Image deleted successfully!");
    } else {
      print("Image not found!");
    }
  } catch (error) {
    print("Error: $error");
  }
}

saveToGallery(BuildContext context, screenshotController) {
  // if (texts.isNotEmpty) {
  // screenshotController.capture(pixelRatio:3.0);
  screenshotController.capture(pixelRatio: 4.0).then((Uint8List? image) {
    saveImage(image!);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Image saved to gallery.'),
      ),
    );
  }).catchError((err) => print("errror ....$err"));
}

saveImage(Uint8List bytes) async {
  final time = DateTime.now()
      .toIso8601String()
      .replaceAll('.', '-')
      .replaceAll(':', '-');
  final name = "screenshot_$time";
  await requestPermission(Permission.storage);
  await ImageGallerySaver.saveImage(bytes, name: name, quality: 100);
}
