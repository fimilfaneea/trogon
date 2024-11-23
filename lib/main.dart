import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogon/bloc/subjects/subject_bloc.dart';
import 'package:trogon/repositories/subject_repo.dart';
import 'package:trogon/presentation/screens/subjects_page.dart';
import 'package:trogon/services/subjects_service.dart';
import 'package:trogon/presentation/screens/videos_page.dart'; // Import VideosPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) {
            return FetchSubjectsService();
          },
        ),
        RepositoryProvider(
          create: (context) {
            return SubjectRepository(
              RepositoryProvider.of<FetchSubjectsService>(context),
            );
          },
        ),
      ],
      child: BlocProvider(
        create: (context) {
          return SubjectBloc(
            RepositoryProvider.of<SubjectRepository>(context),
          );
        },
        child: MaterialApp(
          title: 'LMS',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const SubjectsScreen(),
          routes: {
            '/videos': (context) =>
                const VideosPage(), // Define the route for VideosPage
          },
        ),
      ),
    );
  }
}
