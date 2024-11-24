import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogon/bloc/videos/videos_event.dart';
import 'package:trogon/bloc/videos/videos_state.dart';
import 'package:trogon/repositories/videos_repo.dart';


class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideosRepository _repository;

  VideoBloc(this._repository) : super(VideoInitial()) {
    on<FetchVideos>((event, emit) async {
      emit(VideoLoading());
      try {
        final videos = await _repository.getVideos(event.moduleId);
        emit(VideoLoaded(videos));
      } catch (e) {
        emit(VideoError(e.toString()));
      }
    });
  }
}
