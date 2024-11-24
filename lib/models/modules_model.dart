/// A class representing a module.
///
/// Each module has a unique ID, a title, and a description.
class Module {
  /// The unique identifier of the module.
  final int id;

  /// The title of the module.
  final String title;

  /// The description of the module.
  final String description;

  /// Creates a [Module] with the given [id], [title], and [description].
  Module({
    required this.id,
    required this.title,
    required this.description,
  });

  /// Factory constructor to create a [Module] instance from a JSON map.
  ///
  /// Expects a JSON object with the following keys:
  /// - `id`: An integer representing the module's unique identifier.
  /// - `title`: A string representing the module's title.
  /// - `description`: A string describing the module.
  ///
  /// Throws a `TypeError` if the JSON structure does not match the expected format.
  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json['id'], // The ID is an integer in the API response.
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }
}
