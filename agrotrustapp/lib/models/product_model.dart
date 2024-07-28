import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String sellerId;
  final String name;
  final String image;
  final String description;
  final num price;
  final num units;
  final num rating;
  

  const Product ({
    required this.id,
    required this.sellerId,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.units,
    required this.rating,

  });

  factory Product.fromDocument(DocumentSnapshot doc) {
    return Product(
      id: doc.id,
      sellerId: doc['sellerId'],
      name: doc['name'],
      description: doc['description'],
      image: doc['image'],
      price: doc['price'],
      units: doc['units'],
      rating: doc['rating'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'sellerId': sellerId,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'units': units,
      'rating': rating,


    };
  }
}
