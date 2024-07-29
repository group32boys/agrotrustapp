 import 'package:cloud_firestore/cloud_firestore.dart';

class Seller {
  final String id;
  final String name;
  final String location;
  final String profilePictureUrl;
  final String description;
  final double latitude;
  final double longitude;
  double rating;
  int numberOfRatings;

  Seller({
    required this.id,
    required this.name,
    required this.location,
    required this.profilePictureUrl,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.numberOfRatings,
  });

  factory Seller.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Seller(
      id: doc.id,
      name: data['name'] ?? 'Unknown',
      location: data['location'] ?? 'Unknown location',
      profilePictureUrl: data['profilePictureUrl'] ?? '',
      description: data['description'] ?? 'No description provided',
      latitude: (data['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (data['longitude'] as num?)?.toDouble() ?? 0.0,
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      numberOfRatings: data['numberOfRatings'] as int? ?? 0,
    );
  }

  // Convert Seller to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'profilePictureUrl': profilePictureUrl,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'rating': rating,
      'numberOfRatings': numberOfRatings,
    };
  }

  // Convert Map to Seller
  factory Seller.fromMap(Map<String, dynamic> map) {
    return Seller(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      profilePictureUrl: map['profilePictureUrl'],
      description: map['description'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      rating: map['rating'],
      numberOfRatings: map['numberOfRatings'],
    );
  }
}
