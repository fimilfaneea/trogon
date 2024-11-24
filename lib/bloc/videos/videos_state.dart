/// A Dart file defining the states for the Video Bloc,
/// which manages the state of video-related data within the application.

import 'package:equatable/equatable.dart';
import 'package:trogon/models/videos_model.dart';

/// The base state class for all Video-related states.
/// This class extends [Equatable] to enable value comparisons
/// and ensure efficient state management.
abstract class VideoState extends Equatable {
  /// A list of properties to be used for comparison in Equatable.
  /// Subclasses should override this property if they have their own fields.
  @override
  List<Object?> get props => [];
}

/// Represents the initial state of the Video Bloc before any action occurs.
class VideoInitial extends VideoState {}

/// Represents the state when the Video Bloc is actively loading data.
class VideoLoading extends VideoState {}

/// Represents the state when the Video Bloc successfully loads a list of videos.
class VideoLoaded extends VideoState {
  /// The list of loaded videos.
  final List<Video> videos;

  /// Constructs a [VideoLoaded] state with the provided list of videos.
  ///
  /// - [videos]: A list of [Video] objects that have been successfully loaded.
  VideoLoaded(this.videos);

  /// Overrides [props] to include the [videos] property for value comparison.
  @override
  List<Object?> get props => [videos];
}

/// Represents the state when an error occurs in the Video Bloc.
class VideoError extends VideoState {
  /// The error message describing the issue.
  final String message;

  /// Constructs a [VideoError] state with the provided error message.
  ///
  /// - [message]: A string describing the error that occurred.
  VideoError(this.message);

  /// Overrides [props] to include the [message] property for value comparison.
  @override
  List<Object?> get props => [message];
}
