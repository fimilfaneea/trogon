import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trogon/models/videos_model.dart';

/// A service class responsible for fetching videos for a specific module.
///
/// The [VideosService] class uses the [http] package to send requests to a remote server
/// and fetch a list of videos associated with a given module ID.
class VideosService {
  /// Fetches a list of videos for a given module ID.
  ///
  /// This method sends an HTTP GET request to the `videos.php` endpoint of the API,
  /// passing the [moduleId] as a query parameter. It then decodes the JSON response
  /// and maps it into a list of [Video] objects.
  ///
  /// [moduleId] is the ID of the module for which the videos are being fetched.
  ///
  /// Returns a [Future<List<Video>>] containing a list of [Video] objects.
  ///
  /// Throws an [Exception] if the HTTP request fails or the response status code is not 200.
  Future<List<Video>> fetchVideos(int moduleId) async {
    // Construct the API URL with the moduleId query parameter
    final url = 'https://trogon.info/interview/php/api/videos.php?module_id=$moduleId';
    
    // Send the HTTP GET request to fetch videos
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Decode the JSON response and map it to a list of Video objects
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Video.fromJson(json)).toList();
    } else {
      // Throw an exception if the response is not successful
      throw Exception('Failed to load videos');
    }
  }
}
