import 'package:trogon/services/fetch_api.dart';
import 'package:trogon/models/subject.dart';

class SubjectRepository {
  final ApiService apiService;

  SubjectRepository(this.apiService);

  Future<List<Subject>> getSubjects() async {
    final data = await apiService.fetchSubjects();
    return data.map<Subject>((json) => Subject.fromJson(json)).toList();
  }
}
