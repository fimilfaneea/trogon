// widgets/video_tile.dart

import 'package:flutter/material.dart';
import 'package:trogon/models/videos_model.dart';
import 'package:trogon/presentation/widgets/custom_container.dart';
import 'package:trogon/presentation/screens/video_player.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  const VideoTile({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return ShadowedContainer(
      child: ListTile(
        title: Text(
          video.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
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
      ),
    );
  }
}
