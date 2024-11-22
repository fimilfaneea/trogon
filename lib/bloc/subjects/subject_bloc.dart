import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogon/models/subjects_model.dart';
import 'package:trogon/repositories/subject_repo.dart';

// Events
abstract class SubjectEvent {}

class FetchSubjectsEvent extends SubjectEvent {}

// States
abstract class SubjectState {}

class SubjectInitialState extends SubjectState {}

class SubjectLoadingState extends SubjectState {}

class SubjectLoadedState extends SubjectState {
  final List<Subject> subjects;

  SubjectLoadedState(this.subjects);
}

class SubjectErrorState extends SubjectState {
  final String error;

  SubjectErrorState(this.error);
}

// Bloc
class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final SubjectRepository subjectRepository;

  SubjectBloc(this.subjectRepository) : super(SubjectInitialState()) {
    on<FetchSubjectsEvent>((event, emit) async {
      print("Fetching subjects..."); // Add this line
      try {
        final subjects = await subjectRepository.fetchSubjects();
        print("Subjects fetched: $subjects"); // Add this line
        emit(SubjectLoadedState(subjects));
      } catch (e) {
        print("Error fetching subjects: $e"); // Add this line
        emit(SubjectErrorState("Failed to fetch subjects"));
      }
    });
  }
}
