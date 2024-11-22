import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogon/presentation/screens/modules_screen.dart';
import 'package:trogon/repositories/subjects_repo.dart';
import 'package:trogon/services/api_services.dart';
import 'package:trogon/presentation/screens/subjects_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ApiService()),
        RepositoryProvider(create: (context) => SubjectRepository(RepositoryProvider.of<ApiService>(context))),
      ],
      child: MaterialApp(
        title: 'LMS',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const ModulesPage(subjectId: "4", subjectTitle: "Physics"),
      ),
    );
  }
}
