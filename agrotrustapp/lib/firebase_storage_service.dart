 import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> getProfilePictureUrl(String filePath) async {
    try {
      final ref = _storage.ref().child(filePath);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching profile picture URL: $e');
      }
      return ''; // Return an empty string or a placeholder URL
    }
  }
}
