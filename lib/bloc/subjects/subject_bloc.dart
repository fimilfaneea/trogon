import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogon/models/subjects_model.dart';
import 'package:trogon/repositories/subject_repo.dart';

/// Base class for all subject-related events.
abstract class SubjectEvent {}

/// Event to trigger fetching of subjects.
class FetchSubjectsEvent extends SubjectEvent {}

/// Base class for all subject-related states.
abstract class SubjectState {}

/// Initial state of the subject bloc before any action is taken.
class SubjectInitialState extends SubjectState {}

/// State representing a loading process when fetching subjects.
class SubjectLoadingState extends SubjectState {}

/// State emitted when subjects are successfully fetched.
class SubjectLoadedState extends SubjectState {
  /// List of fetched subjects.
  final List<Subject> subjects;

  /// Creates an instance of [SubjectLoadedState].
  ///
  /// [subjects]: List of subjects that were successfully fetched.
  SubjectLoadedState(this.subjects);
}

/// State emitted when an error occurs while fetching subjects.
class SubjectErrorState extends SubjectState {
  /// Error message describing the failure.
  final String error;

  /// Creates an instance of [SubjectErrorState].
  ///
  /// [error]: The error message to display.
  SubjectErrorState(this.error);
}

/// Bloc class responsible for managing subject-related events and states.
///
/// The [SubjectBloc] listens for [SubjectEvent]s and emits [SubjectState]s
/// to update the UI. It interacts with a [SubjectRepository] to fetch subjects.
class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  /// Repository for handling subject-related data operations.
  final SubjectRepository subjectRepository;

  /// Creates an instance of [SubjectBloc].
  ///
  /// Initializes with the [SubjectInitialState] and sets up event handlers
  /// for managing state transitions.
  SubjectBloc(this.subjectRepository) : super(SubjectInitialState()) {
    // Event handler for fetching subjects.
    on<FetchSubjectsEvent>(_onFetchSubjects);
  }

  /// Handles the [FetchSubjectsEvent].
  ///
  /// Emits:
  /// - [SubjectLoadingState] while the subjects are being fetched.
  /// - [SubjectLoadedState] with the fetched subjects on success.
  /// - [SubjectErrorState] with an error message on failure.
  ///
  /// [event]: The event triggering the state change.
  /// [emit]: Function used to emit new states.
  Future<void> _onFetchSubjects(
      FetchSubjectsEvent event, Emitter<SubjectState> emit) async {
    emit(SubjectLoadingState()); // Emit loading state.
    try {
      // Fetch the subjects from the repository.
      final subjects = await subjectRepository.fetchSubjects();

      // Emit the loaded state with the fetched subjects.
      emit(SubjectLoadedState(subjects));
    } catch (e) {
      // Emit an error state with a failure message.
      emit(SubjectErrorState("Failed to fetch subjects"));
    }
  }
}
