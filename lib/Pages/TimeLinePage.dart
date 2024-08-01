import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/VideoList.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({super.key});

  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  late Future<List<Map<String, String>>> _videosFuture;

  @override
  void initState() {
    super.initState();
    _videosFuture = _fetchVideos();
  }

  Future<List<Map<String, String>>> _fetchVideos() async {
    ListResult result = await FirebaseStorage.instance.ref('videos/').listAll();

    List<Map<String, String>> videos = [];
    for (Reference ref in result.items) {
      String url = await ref.getDownloadURL();
      videos.add({'url': url, 'path': ref.fullPath});
    }
    return videos;
  }

  Future<void> _deleteVideo(String videoPath) async {
    try {
      await FirebaseStorage.instance.ref(videoPath).delete();
      setState(() {
        _videosFuture = _fetchVideos(); // Refresh the list of videos
      });
    } catch (e) {
      // Handle error
      print('Error deleting video: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffD9A9A9),
        title: const Text("Video App Player"),
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
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Map<String, String>>>(
        future: _videosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading videos"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No videos found"));
          } else {
            List<Map<String, String>> videos = snapshot.data!;
            return ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Delete Video"),
                          content: const Text(
                              "Are you sure you want to delete this video?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text("No"),
                            ),
                            TextButton(
                              onPressed: () {
                                _deleteVideo(videos[index]['path']!);
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text("Yes"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: VideoListItem(
                    videoPath: videos[index]['path']!,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}