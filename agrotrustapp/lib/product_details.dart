// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:agrotrustapp/models/product_model.dart';
import 'package:agrotrustapp/services/firebase_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final FirebaseService _firebaseService = FirebaseService();

  ProductDetailScreen({super.key, required this.product});

  Future<void> _orderProduct(BuildContext context) async {
    try {
      final seller = await _firebaseService.fetchSellerById(product.sellerId);
      if (seller != null) {
        final String sellerContact = seller.contact;
        final Uri launchUri = Uri(
          scheme: 'tel',
          path: sellerContact,
        );
        // ignore: deprecated_member_use
        if (await canLaunch(launchUri.toString())) {
          // ignore: deprecated_member_use
          await launch(launchUri.toString());
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not launch dialer')),
          );
        }
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Seller not found')),
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching seller contact: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product.image.isNotEmpty
                ? SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        product.image,
                      ),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: 250,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.image, size: 100, color: Colors.grey),
                    ),
                  ),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Text(
              'Price: Ugx${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, color: Colors.teal, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Unit: ${product.units}',
              style: const TextStyle(fontSize: 18, color: Colors.teal),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () => _orderProduct(context),
                child: const Text('Order'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
