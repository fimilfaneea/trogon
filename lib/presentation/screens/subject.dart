import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogon/bloc/subjects/subject_bloc.dart';
import 'package:trogon/bloc/subjects/subject_event.dart';
import 'package:trogon/bloc/subjects/subject_state.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Subjects")),
      body: BlocProvider(
        create: (context) =>
            SubjectBloc(RepositoryProvider.of(context))..add(FetchSubjects()),
        child: BlocBuilder<SubjectBloc, SubjectState>(
          builder: (context, state) {
            if (state is SubjectLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SubjectLoaded) {
              return ListView.builder(
                itemCount: state.subjects.length,
                itemBuilder: (context, index) {
                  final subject = state.subjects[index];
                  return ListTile(
                    title: Text(subject.title),
                    subtitle: Text(
                        "ID: ${subject.id}"),
                    leading: Image.network(
                        subject.image.replaceAll(RegExp(r'\.jpg$'), '.png')),
                    onTap: () {},
                  );
                },
              );
            } else if (state is SubjectError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
