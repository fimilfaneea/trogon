import 'package:flutter/material.dart';
import 'package:trogon/presentation/widgets/videos_tile.dart';
import 'package:trogon/services/videos_service.dart';
import 'package:trogon/models/videos_model.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({super.key});

  @override
  VideosPageState createState() => VideosPageState();
}

class VideosPageState extends State<VideosPage> {
  late TextEditingController _searchController;
  late Future<List<Video>> _videosFuture;
  List<Video> allVideos = [];
  List<Video> filteredVideos = [];

  int? moduleId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch the module ID passed as argument
    moduleId = ModalRoute.of(context)?.settings.arguments as int?;

    if (moduleId != null && moduleId == 1) {
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

  // Filtering function for videos based on search query
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
              onChanged: (query) {
                setState(() {
                  filteredVideos = _filterVideos(allVideos, query);
                });
              },
            ),
          ),
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

                      // Filtered videos based on the search query
                      final videos = filteredVideos;

                      return ListView.builder(
                        itemCount: videos.length,
                        itemBuilder: (context, index) {
                          final video = videos[index];
                          return VideoTile(video: video); // Use the VideoTile widget
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
