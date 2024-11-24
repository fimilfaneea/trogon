import 'package:trogon/models/modules_model.dart';
import 'package:trogon/services/modules_service.dart';

/// A repository class responsible for fetching and handling modules.
/// It interacts with the [FetchModulesService] to retrieve module data.
class ModulesRepository {
  // The service responsible for fetching the module data from an API or database.
  final FetchModulesService apiService;

  // Constructor that initializes the [apiService].
  ModulesRepository(this.apiService);

  /// Fetches a list of modules for a given subject from the API service.
  ///
  /// The method calls [fetchModules] on the [apiService] to retrieve raw data,
  /// then maps each entry to a [Module] object using [Module.fromJson].
  ///
  /// [subjectId]: The ID of the subject for which modules are to be fetched.
  ///
  /// Returns a list of [Module] objects.
  Future<List<Module>> fetchModules(String subjectId) async {
    // Fetch raw module data from the API service.
    final data = await apiService.fetchModules(subjectId);

    // Map the raw data to a list of Module objects.
    return data.map<Module>((json) => Module.fromJson(json as Map<String, dynamic>)).toList();
  }
}
