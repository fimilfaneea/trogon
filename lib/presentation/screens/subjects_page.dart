import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogon/bloc/subjects/subject_bloc.dart';

import 'package:trogon/presentation/widgets/subjects_tile.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  SubjectsScreenState createState() => SubjectsScreenState();
}

class SubjectsScreenState extends State<SubjectsScreen> {
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
        title: const Text(
          'Subjects',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<SubjectBloc, SubjectState>(
        builder: (context, state) {
          if (state is SubjectInitialState || state is SubjectLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SubjectLoadedState) {
            return ListView.builder(
              itemCount: state.subjects.length,
              itemBuilder: (context, index) {
                // Check if the image URL ends with .jpg, and change it to .png
                String imageUrl = state.subjects[index].image;
                if (imageUrl.endsWith('.jpg')) {
                  imageUrl = imageUrl.replaceAll('.jpg', '.png');
                }
                return SubjectTile(
                    imageUrl: imageUrl,
                    subjectId: state.subjects[index].id,
                    subjectTitle: state.subjects[index].title,
                    subjectDescription: state.subjects[index].description);
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
