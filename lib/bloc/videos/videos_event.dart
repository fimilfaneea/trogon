import 'package:equatable/equatable.dart';

abstract class VideoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchVideos extends VideoEvent {
  final int moduleId;

  FetchVideos(this.moduleId);

  @override
  List<Object?> get props => [moduleId];
}
