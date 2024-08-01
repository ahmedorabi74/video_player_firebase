import 'package:image_picker/image_picker.dart';

Future<String?> pickVideo() async {
  final picker = ImagePicker();
  try {
    final videoFile = await picker.pickVideo(source: ImageSource.gallery);
    return videoFile?.path;
  } catch (e) {
    print("Error picking video: $e");
    return null;
  }
}
