import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:trogon/bloc/modules/modules_bloc.dart';
import 'package:trogon/bloc/subjects/subject_bloc.dart';
import 'package:trogon/presentation/screens/modules_page.dart';
import 'package:trogon/presentation/screens/subjects_page.dart';
import 'package:trogon/presentation/screens/videos_page.dart';
import 'package:trogon/repositories/modules_repo.dart';
import 'package:trogon/repositories/subject_repo.dart';
import 'package:trogon/services/modules_service.dart';
import 'package:trogon/services/subjects_service.dart';

void main() {
  final subjectRepository = SubjectRepository(FetchSubjectsService());
  final modulesRepository = ModulesRepository(FetchModulesService());

  runApp(MyApp(
    subjectRepository: subjectRepository,
    modulesRepository: modulesRepository,
  ));
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  /// Repository to fetch subjects.
  final SubjectRepository subjectRepository;

  /// Repository to fetch modules.
  final ModulesRepository modulesRepository;

  const MyApp({
    super.key,
    required this.subjectRepository,
    required this.modulesRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider<SubjectRepository>(
          create: (_) => subjectRepository,
        ),
        RepositoryProvider<ModulesRepository>(
          create: (_) => modulesRepository,
        ),
        BlocProvider<SubjectBloc>(
          create: (_) => SubjectBloc(subjectRepository),
        ),
        BlocProvider<ModuleBloc>(
          create: (_) => ModuleBloc(modulesRepository),
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
