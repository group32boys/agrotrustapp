class Seller {
  final String name;
  final String profilePictureUrl;
  final double latitude;
  final double longitude;

  Seller({
    required this.name,
    required this.profilePictureUrl,
    required this.latitude,
    required this.longitude,
  });

  factory Seller.fromFirestore(Map<String, dynamic> data) {
    return Seller(
      name: data['name'] ?? '',
      profilePictureUrl: data['profilePictureUrl'] ?? '',
      latitude: (data['latitude'] as num).toDouble(),
      longitude: (data['longitude'] as num).toDouble(),
    );
  }
}
