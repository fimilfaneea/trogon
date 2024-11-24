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

  runApp(MyApp(
    fetchSubjectsService: fetchSubjectsService,
    subjectRepository: subjectRepository,
    fetchModulesService: fetchModulesService,
  ));
}

class MyApp extends StatelessWidget {
  final FetchSubjectsService fetchSubjectsService;
  final SubjectRepository subjectRepository;
  final FetchModulesService fetchModulesService;

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
        // Provide the repositories
        RepositoryProvider<FetchSubjectsService>(
          create: (_) => fetchSubjectsService,
        ),
        RepositoryProvider<SubjectRepository>(
          create: (_) => subjectRepository,
        ),
        RepositoryProvider<FetchModulesService>(
          create: (_) => fetchModulesService,
        ),
        // Provide the Blocs
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
        home: const SubjectsScreen(),
        routes: {
          '/videos': (context) => const VideosPage(),
          '/modules': (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                as Map<String, dynamic>;
            final subjectId = arguments['subjectId'] as String;
            final subjectTitle = arguments['subjectTitle'] as String;

            return ModulesPage(
                subjectId: subjectId, subjectTitle: subjectTitle);
          },
        },
      ),
    );
  }
}
