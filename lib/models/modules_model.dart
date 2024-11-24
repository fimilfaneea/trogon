class Module {
  final int id;
  final String title;
  final String description;

  Module({
    required this.id,
    required this.title,
    required this.description,
  });

  // Factory constructor to create a Module from JSON
  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json['id'], // The ID is an integer in the API response
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }
}
