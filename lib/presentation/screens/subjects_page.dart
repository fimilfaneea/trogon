import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogon/bloc/subjects/subject_bloc.dart';
import 'package:trogon/presentation/screens/modules_page.dart';

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
                // Check if the image URL ends with .jpg, and change it to .png
                String imageUrl = state.subjects[index].image;
                if (imageUrl.endsWith('.jpg')) {
                  imageUrl = imageUrl.replaceAll('.jpg', '.png');
                }

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // On tap, navigate to the ModulesPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ModulesPage(
                              subjectId: state.subjects[index].id,
                              subjectTitle: state.subjects[index].title,
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Image.network(
                          imageUrl, // Use the updated image URL
                          width: 100, // You can adjust the size as needed
                          height: 100, // Adjust the height if needed
                          fit: BoxFit.cover, // Adjust how the image should fit in the space
                        ),
                        title: Column(
                          children: [
                            Text(state.subjects[index].title),
                            Text(
                              state.subjects[index].description,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Add a gap between tiles
                    const SizedBox(height: 10), // Adjust the height as needed
                  ],
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
