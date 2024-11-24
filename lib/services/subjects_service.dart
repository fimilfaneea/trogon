import 'dart:convert';
import 'package:http/http.dart' as http;

/// A service class responsible for fetching subjects from the remote API.
///
/// The [FetchSubjectsService] class uses the [http] package to send requests to
/// a remote server and fetch a list of subjects. It handles HTTP requests and responses.
class FetchSubjectsService {
  /// The base URL of the API for fetching data.
  ///
  /// This URL is used as the endpoint for making requests to the API. It is combined
  /// with specific paths (e.g., `subjects.php`) to fetch different resources.
  final String baseUrl = "https://trogon.info/interview/php/api/";

  /// Fetches the list of subjects from the API.
  ///
  /// This method sends an HTTP GET request to the `subjects.php` endpoint of the API,
  /// decodes the JSON response, and returns the data as a [List<dynamic>].
  ///
  /// Returns a [Future<List<dynamic>>] containing the list of subjects.
  ///
  /// Throws an [Exception] if the HTTP request fails or the response status code is not 200.
  Future<List<dynamic>> fetchSubjects() async {
    // Send the HTTP GET request to fetch subjects
    final response = await http.get(Uri.parse("${baseUrl}subjects.php"));

    if (response.statusCode == 200) {
      // Decode the JSON response and return the result
      final json = jsonDecode(response.body);
      return json;
    } else {
      // Throw an exception if the response is not successful
      throw Exception("Failed to fetch subjects");
    }
  }
}
