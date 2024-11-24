import 'package:trogon/models/subjects_model.dart';
import 'package:trogon/services/subjects_service.dart';

class SubjectRepository {
  final FetchSubjectsService apiService;

  SubjectRepository(this.apiService);

  Future<List<Subject>> fetchSubjects() async {
    final data = await apiService.fetchSubjects();
    return data.map<Subject>((json) => Subject.fromJson(json)).toList();
  }
}
