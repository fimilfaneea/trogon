// bloc/module_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogon/bloc/modules/modules_event.dart';
import 'package:trogon/bloc/modules/modules_state.dart';
import 'package:trogon/services/modules_service.dart';
class ModuleBloc extends Bloc<ModuleEvent, ModuleState> {
  final FetchModulesService apiService;

  ModuleBloc(this.apiService) : super(ModuleInitial()) {
    // Register event handler for FetchModules
    on<FetchModules>(_onFetchModules);
  }

  Future<void> _onFetchModules(FetchModules event, Emitter<ModuleState> emit) async {
    emit(ModuleLoading());
    try {
      final modules = await apiService.fetchModules(event.subjectId);
      emit(ModuleLoaded(modules));
    } catch (e) {
      emit(ModuleError(e.toString()));
    }
  }}
