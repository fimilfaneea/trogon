import 'package:flutter/material.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;
  final String videoTitle;
  final String videoDescription;

  const VideoPlayerPage({
    super.key,
    required this.videoUrl,
    required this.videoTitle,
    required this.videoDescription,
  });

  @override
  VideoPlayerPageState createState() => VideoPlayerPageState();
}

class VideoPlayerPageState extends State<VideoPlayerPage> {
  String? videoId;

  @override
  void initState() {
    super.initState();
    videoId = extractVideoId(widget.videoUrl);
  }

  /// Extract video ID based on whether the URL is Vimeo or YouTube
  String? extractVideoId(String url) {
    if (url.contains("youtube.com") || url.contains("youtu.be")) {
      return YoutubePlayer.convertUrlToId(url);
    } else if (url.contains("vimeo.com")) {
      final segments = Uri.parse(url).pathSegments;
      return segments.isNotEmpty ? segments.last : null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.videoTitle)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video player at the top of the page
          SizedBox(
            height: 250, // Adjust this height as needed
            child: Center(
              child: videoId == null
                  ? const Text("Invalid video URL")
                  : buildVideoPlayer(),
            ),
          ),
          
          // Text content below the video player
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.videoTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.videoDescription,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build the video player dynamically based on URL type
  Widget buildVideoPlayer() {
    if (widget.videoUrl.contains("youtube.com") ||
        widget.videoUrl.contains("youtu.be")) {
      return YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: videoId!,
          flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
        ),
        showVideoProgressIndicator: true,
      );
    } else if (widget.videoUrl.contains("vimeo.com")) {
      return VimeoPlayer(
        videoId: videoId!,
      );
    } else {
      return const Text("Unsupported video platform");
    }
  }
}
