import 'package:flutter/material.dart';
import 'package:trogon/presentation/widgets/videos_tile.dart';
import 'package:trogon/services/videos_service.dart';
import 'package:trogon/models/videos_model.dart';

/// A page displaying a list of videos for a specific module.
///
/// This page allows users to search for videos by title or description.
/// It fetches videos from a service based on the [moduleId] passed in
/// the route and displays them in a list.
class VideosPage extends StatefulWidget {
  const VideosPage({super.key});

  @override
  VideosPageState createState() => VideosPageState();
}

class VideosPageState extends State<VideosPage> {
  /// Controller for the search input field.
  late TextEditingController _searchController;

  /// A future representing the list of videos to be fetched from the service.
  late Future<List<Video>> _videosFuture;

  /// A list to hold all fetched videos.
  List<Video> allVideos = [];

  /// A list to hold the filtered videos based on the search query.
  List<Video> filteredVideos = [];

  /// The ID of the module passed as an argument to this page.
  int? moduleId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch the module ID passed as argument
    moduleId = ModalRoute.of(context)?.settings.arguments as int?;

    if (moduleId != null && moduleId == 1) {
      // If moduleId is 1, fetch the videos using the VideosService
      _videosFuture = VideosService().fetchVideos(moduleId!);
      _videosFuture.then((videos) {
        setState(() {
          allVideos = videos;
          filteredVideos = videos; // Initially, show all videos
        });
      });
    } else {
      // If moduleId is not 1, show no videos
      setState(() {
        allVideos = [];
        filteredVideos = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Filters the list of videos based on the search query.
  ///
  /// The function compares both the title and description of each video
  /// with the search query and returns a list of videos that match.
  ///
  /// [allVideos]: The list of all available videos.
  /// [value]: The search query entered by the user.
  List<Video> _filterVideos(List<Video> allVideos, String value) {
    final lowerCaseValue = value.toLowerCase();
    return allVideos
        .where((video) =>
            video.title.toLowerCase().contains(lowerCaseValue) ||
            video.description.toLowerCase().contains(lowerCaseValue))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Videos'),
      ),
      body: Column(
        children: [
          // Search input field for filtering videos by title or description.
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search videos by title or description',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              // Update the filtered videos list when the search query changes.
              onChanged: (query) {
                setState(() {
                  filteredVideos = _filterVideos(allVideos, query);
                });
              },
            ),
          ),
          // Display videos using FutureBuilder
          Expanded(
            child: moduleId == 1
                ? FutureBuilder<List<Video>>(
                    future: _videosFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No videos available.'));
                      }

                      // Use the filtered videos for the display
                      final videos = filteredVideos;

                      return ListView.builder(
                        itemCount: videos.length,
                        itemBuilder: (context, index) {
                          final video = videos[index];
                          return VideoTile(video: video); // Use the VideoTile widget to display each video
                        },
                      );
                    },
                  )
                : const Center(child: Text('No videos available for this module.')),
          ),
        ],
      ),
    );
  }
}
