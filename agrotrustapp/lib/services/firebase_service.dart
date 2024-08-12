 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:agrotrustapp/models/seller.dart';
import 'package:agrotrustapp/models/product_model.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Fetch sellers
  Future<List<Seller>> fetchSellers() async {
    final snapshot = await _firestore.collection('sellers').get();
    return snapshot.docs.map((doc) {
      return Seller.fromDocument(doc);
    }).toList();
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
        'feedback': FieldValue.arrayUnion([feedback]),
      });
    } else {
      await sellerRef.set({
        'rating': rating,
        'numberOfRatings': 1,
        'feedback': [feedback],
      });
    }
  }

  // Upload a profile picture for a seller
  Future<void> uploadProfilePicture(String filePath, String sellerId) async {
    File file = File(filePath);
    try {
      // Upload file to Firebase Storage
      await _storage.ref('profile_pictures/$sellerId').putFile(file);

      // Get the download URL
      String downloadURL = await _storage.ref('profile_pictures/$sellerId').getDownloadURL();

      // Update the Firestore document with the download URL
      await _firestore.collection('sellers').doc(sellerId).update({
        'profilePictureUrl': downloadURL,
      });
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Failed to upload and update profile picture: ${e.message}');
      }
    }
  }

  // Retrieve profile picture URL
  Future<String?> getProfilePictureUrl(String sellerId) async {
    try {
      String downloadURL = await _storage.ref('profile_pictures/$sellerId').getDownloadURL();
      return downloadURL;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to retrieve profile picture URL: $e');
      }
      return null;
    }
  }
}
