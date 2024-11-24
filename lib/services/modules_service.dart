import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trogon/models/modules_model.dart'; // Make sure the model is imported here

class FetchModulesService {
  final String baseUrl = "https://trogon.info/interview/php/api/";

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
}
