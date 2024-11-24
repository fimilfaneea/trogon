import 'package:flutter/material.dart';
import 'package:trogon/models/videos_model.dart';
import 'package:trogon/presentation/widgets/custom_container.dart';
import 'package:trogon/presentation/screens/video_player.dart';

/// A tile widget that represents a video with its title and description.
///
/// The [VideoTile] widget displays a list item with the video title, description, and
/// provides navigation to a [VideoPlayerPage] when tapped, passing video details.
class VideoTile extends StatelessWidget {
  /// The [Video] object containing the video details.
  ///
  /// This includes the title, description, and video URL, which will be displayed on the tile.
  final Video video;

  /// Creates a [VideoTile] widget to display video information.
  ///
  /// The [video] parameter is required to provide the video details such as title, 
  /// description, and URL for the video player page.
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
                videoUrl: video.videoUrl,
                videoTitle: video.title,
                videoDescription: video.description,
              ),
            ),
          );
        },
      ),
    );
  }
}
