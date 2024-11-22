import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoPlayerPage extends StatelessWidget {
  final String videoType;
  final String videoUrl;
  final String videoTitle;

  const VideoPlayerPage({
    super.key,
    required this.videoType,
    required this.videoUrl,
    required this.videoTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(videoTitle)),
      body: videoType == 'YouTube'
          ? YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: YoutubePlayer.convertUrlToId(videoUrl) ?? '',
                flags: const YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
              onReady: () {
                // On ready to play the video
              },
            )
          : WebViewWidget(controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse(videoUrl))),
    );
  }
}
