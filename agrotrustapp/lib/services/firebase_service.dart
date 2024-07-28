 import 'package:agrotrustapp/firebase_storage_service.dart';
import 'package:agrotrustapp/models/seller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';


class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorageService _storageService = FirebaseStorageService();

  Future<List<Seller>> fetchSellers() async {
    try {
      final snapshot = await _firestore.collection('sellers').get();
      final sellers = <Seller>[];

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final profilePicturePath = data['profilePicturePath'] ?? '';
        final profilePictureUrl = await _storageService.getProfilePictureUrl(profilePicturePath);

        sellers.add(Seller(
          id: doc.id,
          name: data['name'] ?? 'Unknown',
          latitude: (data['latitude'] as num?)?.toDouble() ?? 0.0,
          longitude: (data['longitude'] as num?)?.toDouble() ?? 0.0,
          profilePictureUrl: profilePictureUrl,
          description: data['description'] ?? 'No description provided',
          location: data['location'] ?? 'Unknown location',
          rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
          numberOfRatings: data['numberOfRatings'] as int? ?? 0,
        ));
      }

      return sellers;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching sellers: $e');
      }
      return [];
    }
  }

  Future<void> updateSellerRating(String sellerId, double rating, String feedback) async {
    try {
      final sellerRef = _firestore.collection('sellers').doc(sellerId);

      final sellerDoc = await sellerRef.get();
      final data = sellerDoc.data();

      if (data != null) {
        final currentRating = data['rating'] as num? ?? 0.0;
        final numberOfRatings = data['numberOfRatings'] as int? ?? 0;

        final newRating = ((currentRating * numberOfRatings) + rating) / (numberOfRatings + 1);

        await sellerRef.update({
          'rating': newRating,
          'numberOfRatings': numberOfRatings + 1,
          'feedback': FieldValue.arrayUnion([feedback]), // Assuming feedback is a list of comments
        });
      } else {
        await sellerRef.set({
          'rating': rating,
          'numberOfRatings': 1,
          'feedback': [feedback], // Assuming feedback is a list of comments
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating seller rating: $e');
      }
    }
  }
}
