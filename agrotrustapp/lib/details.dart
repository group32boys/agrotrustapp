 import 'package:agrotrustapp/models/seller.dart';
import 'package:agrotrustapp/product.dart';
import 'package:flutter/material.dart';
 // Adjust the import based on your file structure

class SellerDetailsScreen extends StatelessWidget {
  final Seller seller;

  const SellerDetailsScreen({required this.seller, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(seller.name),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(seller.profilePictureUrl),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                seller.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Location: ${seller.location}',
              style: TextStyle(fontSize: 16, color: Colors.green.shade700),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 8),
            Text(
              seller.descripition,
              style: TextStyle(fontSize: 16, color: Colors.green.shade700),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle the contact seller action
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Contact Seller'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to SellerProductsScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(sellerId: seller.id),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Products'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
