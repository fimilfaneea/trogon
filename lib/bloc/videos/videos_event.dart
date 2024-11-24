import 'package:equatable/equatable.dart';

/// The base class for all video-related events.
///
/// This class extends [Equatable] to simplify state comparison
/// in Bloc, ensuring efficient updates by avoiding unnecessary rebuilds.
abstract class VideoEvent extends Equatable {
  /// Returns a list of properties used for equality comparison.
  ///
  /// Subclasses should override this to include their specific properties.
  @override
  List<Object?> get props => [];
}

/// Event to fetch videos for a specific module.
///
/// This event triggers the process of retrieving all videos
/// associated with a given module ID.
///
/// Example usage:
/// ```dart
/// bloc.add(FetchVideos(101));
/// ```
class FetchVideos extends VideoEvent {
  /// The unique identifier of the module whose videos are to be fetched.
  final int moduleId;

  /// Creates a [FetchVideos] event with the given [moduleId].
  ///
  /// [moduleId] must not be null.
  FetchVideos(this.moduleId);

  /// Returns a list of properties used for equality comparison.
  ///
  /// Includes [moduleId] to ensure accurate state comparison.
  @override
  List<Object?> get props => [moduleId];
}
