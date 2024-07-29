import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String sellerId;
  final String name;
  final String image;
  final String description;
  final num price;
  final num units;

  

  const Product ({
    required this.id,
    required this.sellerId,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.units,

  });

  factory Product.fromDocument(DocumentSnapshot doc) {
    return Product(
      id: doc.id,
      name: doc['name'],
      image: doc['image'],
      description: doc['description'],
      price: doc['price'],
      units: doc['units'],
      sellerId: doc['sellerId'],
    );
  }
}