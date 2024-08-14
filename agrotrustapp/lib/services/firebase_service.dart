import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:agrotrustapp/models/seller.dart';
import 'package:agrotrustapp/models/product_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch sellers
  Future<List<Seller>> fetchSellers() async {
    final snapshot = await _firestore.collection('sellers').get();
    return snapshot.docs.map((doc) {
      doc.data();
      return Seller.fromDocument(doc);
    }).toList();
  }

  // Fetch a single seller by ID
  Future<Seller?> fetchSellerById(String sellerId) async {
    final sellerDoc = await _firestore.collection('sellers').doc(sellerId).get();
    if (sellerDoc.exists) {
      return Seller.fromDocument(sellerDoc);
    } else {
      return null;
    }
  }

  // Fetch products for a seller
  Future<List<Product>> fetchProducts(String sellerId) async {
    final snapshot = await _firestore
        .collection('sellers')
        .doc(sellerId)
        .collection('products')
        .get();

    return snapshot.docs.map((doc) {
      return Product.fromDocument(doc);
    }).toList();
  }

  // Add a product for a seller
  Future<void> addProduct(String sellerId, Product product) async {
    final productRef = _firestore
        .collection('sellers')
        .doc(sellerId)
        .collection('products')
        .doc(product.id);

    await productRef.set(product.toMap());
  }

  // Update a product for a seller
  Future<void> updateProduct(String sellerId, Product product) async {
    final productRef = _firestore
        .collection('sellers')
        .doc(sellerId)
        .collection('products')
        .doc(product.id);

    await productRef.update(product.toMap());
  }

  // Delete a product for a seller
  Future<void> deleteProduct(String sellerId, String productId) async {
    final productRef = _firestore
        .collection('sellers')
        .doc(sellerId)
        .collection('products')
        .doc(productId);

    await productRef.delete();
  }

  // Update seller rating
  Future<void> updateSellerRating(String sellerId, double rating, String feedback, String orderId) async {
    final sellerRef = _firestore.collection('sellers').doc(sellerId);

    await _firestore.runTransaction((transaction) async {
      final sellerSnapshot = await transaction.get(sellerRef);

      if (!sellerSnapshot.exists) {
        throw Exception("Seller not found!");
      }

      final currentRating = sellerSnapshot.get('rating') ?? 0.0;
      final numberOfRatings = sellerSnapshot.get('numberOfRatings') ?? 0;

      final newNumberOfRatings = numberOfRatings + 1;
      final newRating =
          ((currentRating * numberOfRatings) + rating) / newNumberOfRatings;

      transaction.update(sellerRef, {
        'rating': newRating,
        'numberOfRatings': newNumberOfRatings,
      });

      final feedbackRef = sellerRef.collection('feedback').doc();
      transaction.set(feedbackRef, {
        'rating': rating,
        'feedback': feedback,
        'orderId': orderId,
        'timestamp': FieldValue.serverTimestamp(),
      });
    });
  }
}
