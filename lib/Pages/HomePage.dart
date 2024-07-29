import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  late List<FlickManager> flickManagers;

  final List<String> videoUrls = [
    "https://firebasestorage.googleapis.com/v0/b/auth3-4379d.appspot.com/o/videos%2F1.mp4?alt=media&token=1f3ef475-22b2-48fb-ac11-9d15acfbfd1f",
    "https://firebasestorage.googleapis.com/v0/b/auth3-4379d.appspot.com/o/videos%2F2.mp4?alt=media&token=792fda4f-8735-43a2-bffc-f07f8a6284e2",
    "https://firebasestorage.googleapis.com/v0/b/auth3-4379d.appspot.com/o/videos%2F3.mp4?alt=media&token=e0a2a5fa-404b-4384-b4b9-cce8d8b80af3",
    "https://firebasestorage.googleapis.com/v0/b/auth3-4379d.appspot.com/o/videos%2F4.mp4?alt=media&token=8ce483ff-6fb8-4937-a327-4e807d60abd9",
    "https://firebasestorage.googleapis.com/v0/b/auth3-4379d.appspot.com/o/videos%2F5.mp4?alt=media&token=93502639-5630-4c83-81a5-c8bda8a6f8fc",
    "https://firebasestorage.googleapis.com/v0/b/auth3-4379d.appspot.com/o/videos%2F6.mp4?alt=media&token=a8691a3b-dfac-4efd-bb3a-a644a55a09c7",
    "https://firebasestorage.googleapis.com/v0/b/auth3-4379d.appspot.com/o/videos%2F7.mp4?alt=media&token=190d7103-01d7-4295-ad14-f4e6eea3d0dc",
    "https://firebasestorage.googleapis.com/v0/b/auth3-4379d.appspot.com/o/videos%2F55.mp4?alt=media&token=6d9f0b1b-6681-4e57-988e-87f2be7f1fbf",
    "https://firebasestorage.googleapis.com/v0/b/auth3-4379d.appspot.com/o/videos%2F66.mp4?alt=media&token=596c5e55-f621-40df-ab65-8f801d50668f",
    "https://firebasestorage.googleapis.com/v0/b/auth3-4379d.appspot.com/o/videos%2F88.mp4?alt=media&token=ee015f30-a2cb-4011-946a-dc6e06085605",
  ];

  @override
  void initState() {
    super.initState();
    _initializeFlickManagers();
  }

  Future<void> _initializeFlickManagers() async {
    final managers = await Future.wait(
      videoUrls.map((url) async {
        return FlickManager(
          // autoInitialize: false,
          autoPlay: false,
          videoPlayerController: VideoPlayerController.networkUrl(
            Uri.parse(url),
          ),
        );
      }).toList(),
    );
    setState(() {
      flickManagers = managers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffD9A9A9),
        title: const Text("Video Player App"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              await googleSignIn.signOut();
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("LoginPage", (route) => false);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: flickManagers == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 30, bottom: 30),
              child: ListView.separated(
                //padding: EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                itemCount: videoUrls.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 30),
                itemBuilder: (context, index) {
                  return FlickVideoPlayer(
                    flickManager: flickManagers[index],
                  );
                },
              ),
            ),
    );
  }
}
