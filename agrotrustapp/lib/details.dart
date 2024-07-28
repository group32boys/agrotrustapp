import 'package:agrotrustapp/models/seller.dart';
import 'package:agrotrustapp/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'services/firebase_service.dart';

class SellerDetailsScreen extends StatefulWidget {
  final Seller seller;

  const SellerDetailsScreen({required this.seller, super.key});

  @override
  _SellerDetailsScreenState createState() => _SellerDetailsScreenState();
}

class _SellerDetailsScreenState extends State<SellerDetailsScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  double _userRating = 0.0;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.seller.name),
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
                backgroundImage: NetworkImage(widget.seller.profilePictureUrl),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                widget.seller.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Location: ${widget.seller.location}',
              style: TextStyle(fontSize: 16, color: Colors.green.shade700),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 8),
            Text(
              widget.seller.description,
              style: TextStyle(fontSize: 16, color: Colors.green.shade700),
            ),
            const SizedBox(height: 16),
            const Text(
              'Rate this Seller:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 8),
            RatingBar.builder(
              initialRating: _userRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20.0,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _userRating = rating;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Leave a Feedback:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _feedbackController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter your feedback here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const Spacer(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
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
                          builder: (context) => ProductScreen(sellerId: widget.seller.id),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Products'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_userRating > 0) {
                        await _firebaseService.updateSellerRating(
                          widget.seller.id,
                          _userRating,
                          _feedbackController.text,
                        );
                        Navigator.pop(context, _userRating);
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Submit Rating'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
