import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogon/bloc/videos/videos_event.dart';
import 'package:trogon/bloc/videos/videos_state.dart';
import 'package:trogon/repositories/videos_repo.dart';

/// Bloc for managing video-related states and events.
///
/// The [VideoBloc] listens to [VideoEvent] events and emits [VideoState]s
/// to update the UI. It interacts with the [VideosRepository] to fetch videos
/// based on the module ID provided in the events.
class VideoBloc extends Bloc<VideoEvent, VideoState> {
  /// Repository for fetching videos from the data source.
  final VideosRepository _repository;

  /// Creates a [VideoBloc] instance.
  ///
  /// Initializes with the [VideoInitial] state and sets up event handlers
  /// to manage transitions between states.
  ///
  /// [repository]: The repository used to fetch video data.
  VideoBloc(this._repository) : super(VideoInitial()) {
    // Event handler for FetchVideos.
    on<FetchVideos>(_onFetchVideos);
  }

  /// Handles the [FetchVideos] event.
  ///
  /// Emits:
  /// - [VideoLoading] while videos are being fetched.
  /// - [VideoLoaded] with the fetched video list on success.
  /// - [VideoError] with an error message on failure.
  ///
  /// [event]: The [FetchVideos] event containing the module ID.
  /// [emit]: The function used to emit new states.
  Future<void> _onFetchVideos(FetchVideos event, Emitter<VideoState> emit) async {
    emit(VideoLoading()); // Emit the loading state.
    try {
      // Fetch videos for the provided module ID from the repository.
      final videos = await _repository.getVideos(event.moduleId);

      // Emit the loaded state with the fetched video list.
      emit(VideoLoaded(videos));
    } catch (e) {
      // Emit an error state with the error message if fetching fails.
      emit(VideoError(e.toString()));
    }
  }
}
