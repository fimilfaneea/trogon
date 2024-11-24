/// The base class for all subject-related events.
///
/// This class serves as the foundation for any event that can be
/// dispatched to the [SubjectBloc].
abstract class SubjectEvent {}

/// Event to fetch the list of subjects.
///
/// This event triggers the process of retrieving all available subjects,
/// typically for display in a list or selection menu.
///
/// Example usage:
/// ```dart
/// bloc.add(FetchSubjects());
/// ```
class FetchSubjects extends SubjectEvent {}
