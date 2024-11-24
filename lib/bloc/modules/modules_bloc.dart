import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogon/bloc/modules/modules_event.dart';
import 'package:trogon/bloc/modules/modules_state.dart';
import 'package:trogon/repositories/modules_repo.dart';

/// Bloc for handling module-related events and states.
///
/// This Bloc listens for `ModuleEvent` events and emits `ModuleState` states
/// to update the UI accordingly. It interacts with the `ModulesRepository`
/// to fetch data from an API or service.
class ModuleBloc extends Bloc<ModuleEvent, ModuleState> {
  /// Repository for fetching module data.
  final ModulesRepository modulesRepository;

  /// Creates a [ModuleBloc] with the given [ModulesRepository].
  ///
  /// Initializes with the [ModuleInitial] state and registers the event
  /// handler for [FetchModules].
  ModuleBloc(this.modulesRepository) : super(ModuleInitial()) {
    // Register event handler for FetchModules.
    on<FetchModules>(_onFetchModules);
  }

  /// Event handler for fetching modules.
  ///
  /// This method is called when a [FetchModules] event is added to the bloc.
  /// It emits:
  /// - [ModuleLoading] while the data is being fetched.
  /// - [ModuleLoaded] with the fetched modules on success.
  /// - [ModuleError] with an error message on failure.
  ///
  /// [event]: The [FetchModules] event containing the subject ID.
  /// [emit]: The function used to emit new states.
  Future<void> _onFetchModules(
      FetchModules event, Emitter<ModuleState> emit) async {
    emit(ModuleLoading()); // Emit loading state.
    try {
      // Fetch the modules from the repository using the subject ID.
      final modules = await modulesRepository.fetchModules(event.subjectId);

      // Emit the loaded state with the fetched modules.
      emit(ModuleLoaded(modules));
    } catch (e) {
      // Emit an error state with the error message if fetching fails.
      emit(ModuleError(e.toString()));
    }
  }
}
