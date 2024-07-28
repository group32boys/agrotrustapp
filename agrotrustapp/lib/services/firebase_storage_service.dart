 // services/firebase_storage_service.dart

import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

import 'package:flutter/foundation.dart';

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> getProfilePictureUrl(String profilePictureUrl) async {
    try {
      final ref = _firebaseStorage.ref().child(profilePictureUrl);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching profile picture URL: $e');
      }
      return '';
    }
  }
}
