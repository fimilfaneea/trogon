import 'package:flutter/material.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// A StatefulWidget that displays a video player page for either YouTube or Vimeo videos.
///
/// This page contains a video player that can handle YouTube and Vimeo video URLs,
/// along with the title and description of the video.
class VideoPlayerPage extends StatefulWidget {
  /// The URL of the video to be played.
  final String videoUrl;

  /// The title of the video.
  final String videoTitle;

  /// The description of the video.
  final String videoDescription;

  /// Constructs a [VideoPlayerPage] with the provided video URL, title, and description.
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
  /// The video ID extracted from the URL (either YouTube or Vimeo).
  String? videoId;

  @override
  void initState() {
    super.initState();
    // Extract the video ID from the URL during initialization.
    videoId = extractVideoId(widget.videoUrl);
  }

  /// Extracts the video ID from a given video URL.
  /// Supports YouTube and Vimeo video URLs.
  ///
  /// - [url]: The video URL.
  /// Returns the extracted video ID, or null if the URL is invalid.
  String? extractVideoId(String url) {
    if (url.contains("youtube.com") || url.contains("youtu.be")) {
      // Extract video ID for YouTube URL.
      return YoutubePlayer.convertUrlToId(url);
    } else if (url.contains("vimeo.com")) {
      // Extract video ID for Vimeo URL.
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
          // Video player section
          SizedBox(
            height: 250, // Adjust the height as needed for the video player
            child: Center(
              child: videoId == null
                  ? const Text("Invalid video URL")
                  : buildVideoPlayer(),
            ),
          ),
          
          // Text content section (Title and Description)
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

  /// Builds the appropriate video player widget based on the URL type (YouTube or Vimeo).
  ///
  /// Returns a [YoutubePlayer] widget for YouTube videos and a [VimeoPlayer] widget for Vimeo videos.
  /// If the video URL is unsupported, returns a message indicating so.
  Widget buildVideoPlayer() {
    if (widget.videoUrl.contains("youtube.com") || widget.videoUrl.contains("youtu.be")) {
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
