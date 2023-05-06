class FramesModel {
  final String frameno;
  final String farmeimg;
  // final dynamic farme;

  FramesModel({
    required this.frameno,
    required this.farmeimg,
    // required this.farme,
  });

  factory FramesModel.fromData(Map data) {
    return FramesModel(
      frameno: data["title"],
      farmeimg: data["image"],
      // farme: data["screen"],
    );
  }
}
