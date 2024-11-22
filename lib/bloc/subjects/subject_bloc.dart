import 'package:flutter_bloc/flutter_bloc.dart';
import 'subject_event.dart';
import 'subject_state.dart';
import 'package:trogon/repositories/subject.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final SubjectRepository repository;

  SubjectBloc(this.repository) : super(SubjectInitial()) {
    on<FetchSubjects>((event, emit) async {
      emit(SubjectLoading());
      try {
        final subjects = await repository.getSubjects();
        emit(SubjectLoaded(subjects));
      } catch (e) {
        emit(SubjectError(e.toString()));
      }
    });
  }
}
