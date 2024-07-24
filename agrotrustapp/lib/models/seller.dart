 import 'package:cloud_firestore/cloud_firestore.dart';

class Seller {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final String profilePictureUrl;
  final String location;
  final String descripition;

  Seller({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.profilePictureUrl,
    required this.location,
    required this.descripition,
  });

  factory Seller.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Seller(
      id: doc.id,
      name: data['name'] ?? 'Unknown',
      latitude: (data['latitude'] ?? 0.0).toDouble(),
      longitude: (data['longitude'] ?? 0.0).toDouble(),
      profilePictureUrl: data['profilePictureUrl'] ?? '',
      location: data['location'] ?? 'Unknown',
      descripition: data['description'] ?? 'No description',
    );
  }
}
