 import 'package:agrotrustapp/models/seller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Seller>> fetchSellers() async {
    final snapshot = await _firestore.collection('sellers').get();
    return snapshot.docs.map((doc) {
      // ignore: unnecessary_cast
      final data = doc.data() as Map<String, dynamic>;

      return Seller(
        id: doc.id,
        name: data['name'] ?? 'Unknown',
        latitude: (data['latitude'] as num?)?.toDouble() ?? 0.0,
        longitude: (data['longitude'] as num?)?.toDouble() ?? 0.0,
        profilePictureUrl: data['profilePictureUrl'] ?? '',
        descripition: data['description'] ?? 'No description provided',
        location: data['location'] ?? 'Unknown location',
      );
    }).toList();
  }
}
