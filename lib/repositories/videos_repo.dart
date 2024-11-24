import 'package:trogon/models/videos_model.dart';
import 'package:trogon/services/videos_service.dart';

/// A repository class that handles the fetching of videos.
///
/// The [VideosRepository] acts as an intermediary between the application and the
/// [VideosService]. It provides a method to retrieve a list of videos for a specific module.
class VideosRepository {
  /// The [VideosService] instance used to interact with the video service.
  ///
  /// This service is responsible for fetching the videos from the backend or remote data source.
  final VideosService _service;

  /// Creates an instance of [VideosRepository] with the given [VideosService].
  ///
  /// The [VideosService] is injected via the constructor to fetch the list of videos.
  VideosRepository(this._service);

  /// Fetches a list of videos for a given module ID.
  ///
  /// This method retrieves the videos associated with the specified [moduleId].
  /// It calls the [VideosService.fetchVideos] method to fetch the data asynchronously.
  ///
  /// Returns a [Future<List<Video>>] containing a list of [Video] objects.
  Future<List<Video>> getVideos(int moduleId) async {
    return await _service.fetchVideos(moduleId);
  }
}
