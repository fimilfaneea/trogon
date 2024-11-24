import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogon/bloc/subjects/subject_bloc.dart';
import 'package:trogon/repositories/subject_repo.dart';
import 'package:trogon/presentation/screens/subjects_page.dart';
import 'package:trogon/services/subjects_service.dart';
import 'package:trogon/presentation/screens/videos_page.dart'; // Import VideosPage
import 'package:trogon/bloc/modules/modules_bloc.dart'; // Import ModuleBloc
import 'package:trogon/services/modules_service.dart'; // Import ModulesService
import 'package:trogon/presentation/screens/modules_page.dart'; // Import ModulesPage
import 'package:provider/provider.dart';

void main() {
  // Initialize repositories first
  final fetchSubjectsService = FetchSubjectsService();
  final subjectRepository = SubjectRepository(fetchSubjectsService);
  final fetchModulesService = FetchModulesService();

  // Run the app with necessary services and repositories
  runApp(MyApp(
    fetchSubjectsService: fetchSubjectsService,
    subjectRepository: subjectRepository,
    fetchModulesService: fetchModulesService,
  ));
}

/// Main application widget that initializes necessary services and repositories.
///
/// This widget is the entry point for the application and sets up providers for the 
/// necessary services, repositories, and Blocs. It also defines the routes for the app.
class MyApp extends StatelessWidget {
  /// Service to fetch subjects.
  final FetchSubjectsService fetchSubjectsService;

  /// Repository for handling subjects.
  final SubjectRepository subjectRepository;

  /// Service to fetch modules.
  final FetchModulesService fetchModulesService;

  /// Constructor that accepts the required services and repositories.
  const MyApp({
    super.key,
    required this.fetchSubjectsService,
    required this.subjectRepository,
    required this.fetchModulesService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide the repositories for fetching subjects and modules
        RepositoryProvider<FetchSubjectsService>(
          create: (_) => fetchSubjectsService,
        ),
        RepositoryProvider<SubjectRepository>(
          create: (_) => subjectRepository,
        ),
        RepositoryProvider<FetchModulesService>(
          create: (_) => fetchModulesService,
        ),
        // Provide the Blocs that will manage the states of subjects and modules
        BlocProvider<SubjectBloc>(
          create: (_) => SubjectBloc(subjectRepository),
        ),
        BlocProvider<ModuleBloc>(
          create: (_) => ModuleBloc(fetchModulesService),
        ),
      ],
      child: MaterialApp(
        title: 'LMS',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const SubjectsScreen(), // Initial screen when the app loads
        routes: {
          // Define the routes for the app navigation
          '/videos': (context) => const VideosPage(),
          '/modules': (context) {
            // Extract arguments passed to the modules screen
            final arguments = ModalRoute.of(context)?.settings.arguments
                as Map<String, dynamic>;
            final subjectId = arguments['subjectId'] as String;
            final subjectTitle = arguments['subjectTitle'] as String;

            // Return the ModulesPage with the subject details
            return ModulesPage(
                subjectId: subjectId, subjectTitle: subjectTitle);
          },
        },
      ),
    );
  }
}
