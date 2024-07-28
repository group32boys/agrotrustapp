import 'package:agrotrustapp/models/seller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Seller>> fetchSellers() async {
    final snapshot = await _firestore.collection('sellers').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();

      return Seller(
        id: doc.id,
        name: data['name'] ?? 'Unknown',
        latitude: (data['latitude'] as num?)?.toDouble() ?? 0.0,
        longitude: (data['longitude'] as num?)?.toDouble() ?? 0.0,
        profilePictureUrl: data['profilePictureUrl'] ?? '',
        description: data['description'] ?? 'No description provided',
        location: data['location'] ?? 'Unknown location',
        rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
        numberOfRatings: data['numberOfRatings'] as int? ?? 0,
      );
    }).toList();
  }

  Future<void> updateSellerRating(String sellerId, double rating, String feedback) async {
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
  }
}
