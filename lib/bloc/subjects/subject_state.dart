/// A Dart file defining the states for the Subject Bloc,
/// which manages the state of subject-related data within the application.
library;

import 'package:trogon/models/subjects_model.dart';

/// The base state class for all Subject-related states.
/// This class is extended by all specific states in the Subject Bloc.
abstract class SubjectState {}

/// Represents the initial state of the Subject Bloc before any action occurs.
class SubjectInitial extends SubjectState {}

/// Represents the state when the Subject Bloc is actively loading data.
class SubjectLoading extends SubjectState {}

/// Represents the state when the Subject Bloc successfully loads a list of subjects.
class SubjectLoaded extends SubjectState {
  /// The list of loaded subjects.
  final List<Subject> subjects;

  /// Constructs a [SubjectLoaded] state with the provided list of subjects.
  ///
  /// - [subjects]: A list of [Subject] objects that have been successfully loaded.
  SubjectLoaded(this.subjects);
}

/// Represents the state when an error occurs in the Subject Bloc.
class SubjectError extends SubjectState {
  /// The error message describing the issue.
  final String message;

  /// Constructs a [SubjectError] state with the provided error message.
  ///
  /// - [message]: A string describing the error that occurred.
  SubjectError(this.message);
}
