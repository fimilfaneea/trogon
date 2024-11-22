import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trogon/models/modules.dart';

class ApiService {
  final String baseUrl = "https://trogon.info/interview/php/api/";
  Future<List<dynamic>> fetchSubjects() async {
    final response = await http.get(Uri.parse("${baseUrl}subjects.php"));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json;
    } else {
      throw Exception("Failed to fetch subjects");
    }
  }

  Future<List<Module>> fetchModules(String subjectId) async {
    final response = await http
        .get(Uri.parse('${baseUrl}modules.php?subject_id=$subjectId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((module) => Module.fromJson(module)).toList();
    } else {
      throw Exception('Failed to load modules');
    }
  }

  Future<List<dynamic>> fetchVideos(String moduleId) async {
    final response =
        await http.get(Uri.parse("${baseUrl}videos.php?module_id=$moduleId"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch videos");
    }
  }
}
