/// Represents a subject with an ID, title, description, and associated image.
///
/// The [Subject] class is used to model a subject entity, typically used
/// in educational or content-based applications. It contains fields for
/// the subject's unique identifier, title, description, and an image URL.
class Subject {
  /// The unique identifier of the subject.
  ///
  /// This is often used to fetch or identify a subject in databases or APIs.
  /// It is stored as a [String] to support compatibility with widgets
  /// like [Text] or similar components that require a string input.
  final String id;

  /// The title or name of the subject.
  ///
  /// This is the main identifier presented to the user.
  final String title;

  /// A brief description of the subject.
  ///
  /// This provides additional details about the subject to the user.
  final String description;

  /// The image URL associated with the subject.
  ///
  /// This URL points to the subject's image, which can be displayed in
  /// the UI to help visualize the subject.
  final String image;

  /// Creates a new [Subject] instance with the provided properties.
  ///
  /// The [id], [title], [description], and [image] are required parameters
  /// to create a subject object.
  Subject({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  /// Creates a [Subject] instance from a JSON map.
  ///
  /// This factory constructor is used to convert a [Map<String, dynamic>]
  /// (typically from an API response) into a [Subject] object. It expects
  /// the map to contain the keys 'id', 'title', 'description', and 'image'.
  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'].toString(), // Convert int to String for consistent handling
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
    );
  }
}
