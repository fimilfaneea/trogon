import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogon/bloc/subjects/subject_bloc.dart';
import 'package:trogon/repositories/subject_repo.dart';
import 'package:trogon/presentation/screens/subjects_page.dart';
import 'package:trogon/services/subjects_service.dart';

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
            print("FetchSubjectsService initialized");
            return FetchSubjectsService();
          },
        ),
        RepositoryProvider(
          create: (context) {
            print("SubjectRepository initialized");
            return SubjectRepository(
              RepositoryProvider.of<FetchSubjectsService>(context),
            );
          },
        ),
      ],
      child: BlocProvider(
        create: (context) {
          print("SubjectBloc initialized");
          return SubjectBloc(
            RepositoryProvider.of<SubjectRepository>(context),
          );
        },
        child: MaterialApp(
          title: 'LMS',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const SubjectsScreen(),
        ),
      ),
    );
  }
}
