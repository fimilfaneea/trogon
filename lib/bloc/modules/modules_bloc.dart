import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogon/bloc/modules/modules_event.dart';
import 'package:trogon/bloc/modules/modules_state.dart';
import 'package:trogon/services/api_services.dart';

class ModuleBloc extends Bloc<ModuleEvent, ModuleState> {
  final ApiService apiService;

  ModuleBloc(this.apiService) : super(ModuleInitial()) {
    // Handle FetchModules event
    on<FetchModules>((event, emit) async {
      try {
        emit(ModuleLoading());
        final modules = await apiService.getModules(event.subjectId); // Assuming this fetches modules for a subject
        emit(ModuleLoaded(modules: modules));
      } catch (e) {
        emit(ModuleError(message: e.toString()));
      }
    });
  }
}
