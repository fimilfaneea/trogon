/// A class representing a video with its details.
///
/// This class is used to model a video entity with its associated properties such as
/// `id`, `title`, `description`, `videoType` (e.g., YouTube, Vimeo), and `videoUrl`.
class Video {
  /// The unique identifier for the video.
  final int id;

  /// The title of the video.
  final String title;

  /// A brief description of the video.
  final String description;

  /// The type of video platform (e.g., YouTube or Vimeo).
  final String videoType;

  /// The URL of the video.
  final String videoUrl;

  /// Constructs a [Video] object with the required properties.
  ///
  /// - [id]: A unique identifier for the video.
  /// - [title]: The title of the video.
  /// - [description]: A brief description of the video.
  /// - [videoType]: The type of video platform (e.g., YouTube or Vimeo).
  /// - [videoUrl]: The URL of the video.
  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.videoType,
    required this.videoUrl,
  });

  /// A factory constructor that creates a [Video] object from a JSON map.
  ///
  /// This method parses the provided [json] map to extract the necessary data
  /// and returns a new instance of [Video].
  ///
  /// - [json]: A map representing a video in JSON format, with keys `id`, `title`, 
  ///   `description`, `video_type`, and `video_url`.
  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      videoType: json['video_type'],
      videoUrl: json['video_url'],
    );
  }
}
