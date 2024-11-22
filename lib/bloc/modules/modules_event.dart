// bloc/module_event.dart

abstract class ModuleEvent {}

class FetchModules extends ModuleEvent {
  final String subjectId;

  FetchModules(this.subjectId);
}
