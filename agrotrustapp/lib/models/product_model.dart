import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price;
  final String units;
  final String sellerId;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.units,
    required this.sellerId,
  });

  factory Product.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['name'] ?? 'Unknown',
      description: data['description'] ?? 'No description provided',
      image: data['image'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      units: data['units'] ?? 'units',
      sellerId: data['sellerId'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': image,
      'price': price,
      'unit': units,
      'sellerId': sellerId,
    };
  }
}
