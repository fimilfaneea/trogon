import 'package:trogon/models/videos_model.dart';
import 'package:trogon/services/videos_service.dart';


class VideosRepository {
  final VideosService _service;

  VideosRepository(this._service);

  Future<List<Video>> getVideos(int moduleId) async {
    return await _service.fetchVideos(moduleId);
  }
}
