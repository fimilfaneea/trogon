import 'package:trogon/models/subjects_model.dart';
import 'package:trogon/services/subjects_service.dart';

/// A repository class responsible for fetching and handling subjects.
/// It interacts with the [FetchSubjectsService] to retrieve subject data.
class SubjectRepository {
  // The service responsible for fetching the subject data from an API or database.
  final FetchSubjectsService apiService;

  // Constructor that initializes the [apiService].
  SubjectRepository(this.apiService);

  /// Fetches a list of subjects from the API service.
  ///
  /// The method calls [fetchSubjects] on the [apiService] to retrieve raw data,
  /// then maps each entry to a [Subject] object using [Subject.fromJson].
  ///
  /// Returns a list of [Subject] objects.
  Future<List<Subject>> fetchSubjects() async {
    // Fetch raw subject data from the API service.
    final data = await apiService.fetchSubjects();

    // Map the raw data to a list of Subject objects.
    return data.map<Subject>((json) => Subject.fromJson(json)).toList();
  }
}
