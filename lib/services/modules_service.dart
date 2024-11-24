import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trogon/models/modules_model.dart'; // Make sure the model is imported here

/// A service class responsible for fetching module data from the API.
///
/// This service communicates with the backend to retrieve a list of modules
/// associated with a particular subject using the [subjectId].
class FetchModulesService {
  // Base URL for the API.
  final String baseUrl = "https://trogon.info/interview/php/api/";

  /// Fetches the list of modules for a given subject ID.
  ///
  /// This method sends an HTTP GET request to the API and fetches modules
  /// for the specified [subjectId]. If the request is successful (status code 200),
  /// it decodes the JSON response and returns a list of [Module] objects.
  ///
  /// If the request fails, it throws an exception.
  ///
  /// Parameters:
  /// - [subjectId]: The ID of the subject for which modules are to be fetched.
  ///
  /// Returns:
  /// - A [Future] containing a list of [Module] objects.
  ///
  /// Throws:
  /// - [Exception]: If the API request fails or the response has an error status.
  Future<List<Module>> fetchModules(String subjectId) async {
    // Make an HTTP GET request to fetch module data.
    final response = await http
        .get(Uri.parse('${baseUrl}modules.php?subject_id=$subjectId'));

    // Check if the response status is OK (200).
    if (response.statusCode == 200) {
      // Decode the JSON response.
      final List<dynamic> data = json.decode(response.body);

      // Map the decoded data to a list of Module objects.
      return data.map((module) => Module.fromJson(module)).toList();
    } else {
      // Throw an exception if the status code is not 200.
      throw Exception('Failed to load modules');
    }
  }
}
