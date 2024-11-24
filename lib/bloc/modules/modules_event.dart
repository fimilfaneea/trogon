// bloc/module_event.dart

/// The base class for all module-related events.
///
/// This class serves as the foundation for any event that can be
/// dispatched to the [ModuleBloc].
abstract class ModuleEvent {}

/// Event to fetch modules for a specific subject.
///
/// This event triggers the process of retrieving all modules
/// associated with a given subject.
///
/// Example usage:
/// ```dart
/// bloc.add(FetchModules('subject123'));
/// ```
class FetchModules extends ModuleEvent {
  /// The unique identifier of the subject whose modules are to be fetched.
  final String subjectId;

  /// Creates a [FetchModules] event with the given [subjectId].
  ///
  /// [subjectId] must not be null or empty.
  FetchModules(this.subjectId);
}
