import 'package:trogon/services/api_services.dart';
import 'package:trogon/models/subjects_model.dart';

class SubjectRepository {
  final ApiService apiService;

  SubjectRepository(this.apiService);

  Future<List<Subject>> getSubjects() async {
    final data = await apiService.fetchSubjects();
    return data.map<Subject>((json) => Subject.fromJson(json)).toList();
  }
}