import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trogon/models/videos_model.dart';


class VideosService {
  Future<List<Video>> fetchVideos(int moduleId) async {
    final url = 'https://trogon.info/interview/php/api/videos.php?module_id=$moduleId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Video.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load videos');
    }
  }
}
