import 'package:agrotrustapp/models/seller.dart';
import 'package:flutter/material.dart';

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
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(seller.profilePictureUrl),
            ),
            const SizedBox(height: 16),
            Text(
              seller.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
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
            ElevatedButton(
              onPressed: () {
                // Handle the action (e.g., Contact Seller)
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Contact Seller'),
            ),
          ],
        ),
      ),
    );
  }
}
