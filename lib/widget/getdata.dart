import '../model/days/days_model.dart';
import '../model/days/samlpe_data.dart';
import '../model/frame/frame_model.dart';
import '../model/frame/frames_data.dart';
import '../model/video/video_data.dart';
import '../model/video/video_model.dart';

Stream<List<FramesModel>> getData() async* {
  yield sampleFrame.map((e) => FramesModel.fromData(e)).toList();
}

Stream<List<ProductModel>> getProductData() async* {
  yield await Future.delayed(
    const Duration(milliseconds: 500),
    () => sampleData.map((e) => ProductModel.fromData(e)).toList(),
  );
}

Stream<List<VideoModel>> getVideoData() async* {
  yield await Future.delayed(
    const Duration(milliseconds: 500),
    () => videosdata.map((e) => VideoModel.fromData(e)).toList(),
  );
}
