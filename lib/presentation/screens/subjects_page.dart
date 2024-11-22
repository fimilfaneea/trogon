import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogon/bloc/subjects/subject_bloc.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  SubjectsScreenState createState() =>
      SubjectsScreenState(); // Renamed to public class name
}

class SubjectsScreenState extends State<SubjectsScreen> {
  // Renamed to public class name
  @override
  void initState() {
    super.initState();
    // Dispatch the FetchSubjectsEvent to trigger the fetch operation
    BlocProvider.of<SubjectBloc>(context).add(FetchSubjectsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subjects'),
      ),
      body: BlocBuilder<SubjectBloc, SubjectState>(
        builder: (context, state) {
          if (state is SubjectInitialState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SubjectLoadedState) {
            return ListView.builder(
              itemCount: state.subjects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.subjects[index].title),
                );
              },
            );
          } else if (state is SubjectErrorState) {
            return Center(child: Text(state.error));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
