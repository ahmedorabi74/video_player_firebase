import 'package:firebase_storage/firebase_storage.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoListItem extends StatefulWidget {
  final String videoPath; // Path in Firebase Storage

  const VideoListItem({super.key, required this.videoPath});

  @override
  VideoListItemState createState() => VideoListItemState();
}

class VideoListItemState extends State<VideoListItem> {
  late FlickManager flickManager;
  late Future<void> _initializeVideoFuture;

  @override
  void initState() {
    super.initState();
    _initializeVideoFuture = _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    String downloadUrl = await FirebaseStorage.instance
        .ref(widget.videoPath)
        .getDownloadURL();

    flickManager = FlickManager(
      autoPlay: false,
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(downloadUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error loading video"));
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 14, right: 18, left: 18, top: 4),
            child: SizedBox(
              child: FlickVideoPlayer(
                flickManager: flickManager,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }
}
