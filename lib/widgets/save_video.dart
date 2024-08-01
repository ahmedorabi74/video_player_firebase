import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseStorage storge = FirebaseStorage.instance;
final FirebaseFirestore fireStore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadVideo(String videoUrl) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child('videos/${DateTime.now().toIso8601String()}.mp4');
      await ref.putFile(File(videoUrl));
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading video: $e ❌❌❌❌❌❌❌❌❌❌❌');
      rethrow; // Optionally rethrow to handle it in the calling method
    }
  }

  Future<void> saveVideoData(String videoDownloadUrl) async {
    try {
      await FirebaseFirestore.instance.collection('videos').add({
        'url': videoDownloadUrl,
        'timeStamp': FieldValue.serverTimestamp(),
        'name': 'User Video'
      });
    } catch (e) {
      print('Error saving video data: ❌❌❌❌❌❌❌❌❌❌❌$e');
    }
  }
}

