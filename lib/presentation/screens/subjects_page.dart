import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogon/bloc/subjects/subject_bloc.dart';
import 'package:trogon/presentation/widgets/subjects_tile.dart';

/// A screen that displays a list of subjects.
///
/// This screen listens to the [SubjectBloc] and displays subjects fetched from
/// the backend. It shows a loading spinner while waiting for the subjects to load,
/// and an error message if the fetching operation fails.
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
    // This ensures that the list of subjects is fetched when the screen is loaded.
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
          // Show a loading indicator if the state is initial or loading
          if (state is SubjectInitialState || state is SubjectLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } 
          // Display subjects if successfully loaded
          else if (state is SubjectLoadedState) {
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
                  subjectDescription: state.subjects[index].description,
                );
              },
            );
          } 
          // Show error message if an error occurred
          else if (state is SubjectErrorState) {
            return Center(child: Text(state.error));
          }
          // Return an empty widget if no state is matched
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
