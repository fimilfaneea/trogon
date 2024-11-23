import 'dart:convert';
import 'package:http/http.dart' as http;

class FetchSubjectsService {
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
}
