import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String sellerId;
  final String name;
  final String image;
  final String description;
  final num price;
  final num unit;
  final num rating;
  

  const Product ({
    required this.sellerId,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.unit,
    required this.rating,

  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      sellerId: doc['sellerId'],
      name: data['name'] ?? 'Unknown',
      description: data['description'] ?? 'No description provided',
      image: data['image'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      unit: data['units'] ?? 'Unknown units',
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Product>> fetchProducts() async {
    final snapshot = await _firestore.collection('products').get();
    return snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
  }
}