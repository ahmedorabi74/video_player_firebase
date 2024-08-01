import 'dart:io';

import 'package:auth3/widgets/save_video.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/utiles.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({super.key});

  @override
  State<UploadVideo> createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  String? videoUrl;
  VideoPlayerController? controller;
  String? downloadURL;
  bool isLoading = false; // Move isLoading here

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffD9A9A9),
          title: const Text("Video App Player"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await pickVideos();
          },
          child: Icon(
            Icons.video_library,
            color: Colors.blue,
          ),
        ),
        body: Center(
          child: videoUrl != null
              ? videoPreviewWidget()
              : Text("No videos selected!"),
        ),
      ),
    );
  }

  Future<void> pickVideos() async {
    final path = await pickVideo();
    if (path != null) {
      setState(() {
        videoUrl = path;
        initializeVideoPlayer();
      });
    }
  }

  void initializeVideoPlayer() {
    if (videoUrl != null) {
      controller = VideoPlayerController.file(File(videoUrl!))
        ..initialize().then((_) {
          setState(() {
            controller!.play();
          });
        }).catchError((error) {
          print('Error initializing video player: $error');
        });
    }
  }

  Widget videoPreviewWidget() {
    if (controller != null && controller!.value.isInitialized) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: controller!.value.aspectRatio,
            child: VideoPlayer(controller!),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });

              await uploadVideos();
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("video upload successfully ✅✅"),
                  duration: const Duration(seconds: 3),

                ),
              );
            },
            child: const Text(
              "Upload",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
        ],
      );
    } else {
      return const CircularProgressIndicator();
    }
  }

  Future<void> uploadVideos() async {
    if (videoUrl != null) {
      print("Attempting to upload video from: $videoUrl");
      try {
        print("Uploading video...✅✅✅");
        downloadURL = await StoreData().uploadVideo(videoUrl!);
        print("Video uploaded. Download URL: ✅✅✅$downloadURL");

        print("Saving video data to Firestore...✅✅✅");
        await StoreData().saveVideoData(downloadURL!);
        print("Video data saved.✅✅✅✅✅✅✅");

        setState(() {
          videoUrl = null;
        });
      } catch (e) {
        print("Error during upload: $e");
      }
    } else {
      print("No video URL found!");
    }
  }
}
