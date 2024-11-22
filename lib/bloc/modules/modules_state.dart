// bloc/module_state.dart

import 'package:trogon/models/modules_model.dart';


abstract class ModuleState {}

class ModuleInitial extends ModuleState {}

class ModuleLoading extends ModuleState {}

class ModuleLoaded extends ModuleState {
  final List<Module> modules;

  ModuleLoaded(this.modules);
}

class ModuleError extends ModuleState {
  final String message;

  ModuleError(this.message);
}
