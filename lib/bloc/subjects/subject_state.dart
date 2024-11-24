/// A Dart file defining the states for the Module Bloc,
/// which manages the state of module-related data within the application.
library;

import 'package:trogon/models/modules_model.dart';

/// The base state class for all Module-related states.
/// This class is extended by all specific states in the Module Bloc.
abstract class ModuleState {}

/// Represents the initial state of the Module Bloc before any action occurs.
class ModuleInitial extends ModuleState {}

/// Represents the state when the Module Bloc is actively loading data.
class ModuleLoading extends ModuleState {}

/// Represents the state when the Module Bloc successfully loads a list of modules.
class ModuleLoaded extends ModuleState {
  /// The list of loaded modules.
  final List<Module> modules;

  /// Constructs a [ModuleLoaded] state with the provided list of modules.
  ///
  /// - [modules]: A list of [Module] objects that have been successfully loaded.
  ModuleLoaded(this.modules);
}

/// Represents the state when an error occurs in the Module Bloc.
class ModuleError extends ModuleState {
  /// The error message describing the issue.
  final String message;

  /// Constructs a [ModuleError] state with the provided error message.
  ///
  /// - [message]: A string describing the error that occurred.
  ModuleError(this.message);
}
