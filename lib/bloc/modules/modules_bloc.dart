/// Bloc class responsible for managing the state of modules.
///
/// The `ModuleBloc` listens to `ModuleEvent` events and emits `ModuleState`
/// states to update the UI accordingly. It interacts with the `FetchModulesService`
/// to fetch data from an API or service.
library;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogon/bloc/modules/modules_event.dart';
import 'package:trogon/bloc/modules/modules_state.dart';
import 'package:trogon/services/modules_service.dart';

/// Bloc for handling module-related events and states.
///
/// This Bloc takes a `FetchModulesService` for fetching modules and listens for
/// `ModuleEvent` events. It emits states such as `ModuleLoading`, `ModuleLoaded`,
/// and `ModuleError` based on the outcome of operations.
class ModuleBloc extends Bloc<ModuleEvent, ModuleState> {
  /// Service for fetching module data.
  final FetchModulesService apiService;

  /// Creates a [ModuleBloc] with the given [FetchModulesService].
  ///
  /// Initializes with the [ModuleInitial] state and registers the event
  /// handler for [FetchModules].
  ModuleBloc(this.apiService) : super(ModuleInitial()) {
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
  Future<void> _onFetchModules(FetchModules event, Emitter<ModuleState> emit) async {
    emit(ModuleLoading()); // Emit loading state.
    try {
      // Fetch the modules from the API service using the subject ID.
      final modules = await apiService.fetchModules(event.subjectId);

      // Emit the loaded state with the fetched modules.
      emit(ModuleLoaded(modules));
    } catch (e) {
      // Emit an error state with the error message if fetching fails.
      emit(ModuleError(e.toString()));
    }
  }
}
