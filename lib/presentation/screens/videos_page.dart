import 'package:flutter/material.dart';
import 'package:trogon/presentation/screens/video_player.dart';
import 'package:trogon/services/videos_service.dart';
import 'package:trogon/models/videos_model.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({super.key});

  @override
  VideosPageState createState() => VideosPageState();
}

class VideosPageState extends State<VideosPage> {
  late Future<List<Video>> _videos;
  int? moduleId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch the module ID passed as argument
    moduleId = ModalRoute.of(context)?.settings.arguments as int?;
    if (moduleId != null) {
      _videos = VideosService().fetchVideos(moduleId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Videos')),
      body: FutureBuilder<List<Video>>(
        future: _videos,
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

          final videos = snapshot.data!;

          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];

              return ListTile(
                title: Text(video.title),
                subtitle: Text(video.description),
                onTap: () {
                  // Navigate to VideoPlayerPage with video details
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerPage(
                        videoType: video.videoType,
                        videoUrl: video.videoUrl,
                        videoTitle: video.title,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
