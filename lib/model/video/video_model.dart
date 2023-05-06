class VideoModel {
  final String title;
  final String image;
  final String video;

  VideoModel({
    required this.title,
    required this.image,
    required this.video,
  });

  factory VideoModel.fromData(Map data) {
    return VideoModel(
      title: data["title"] ?? "Video Title",
      image: data["image"] ?? "Video Image",
      video: data["video"] ?? "Video Title",
    );
  }
}
