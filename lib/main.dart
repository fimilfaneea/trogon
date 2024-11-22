import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogon/repositories/subject.dart';
import 'package:trogon/services/fetch_api.dart';
import 'package:trogon/presentation/screens/subject.dart';

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
        home: const SubjectsScreen(),
      ),
    );
  }
}
