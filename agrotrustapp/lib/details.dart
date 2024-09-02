import 'package:agrotrustapp/models/seller.dart';
import 'package:agrotrustapp/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'services/firebase_service.dart';

class SellerDetailsScreen extends StatefulWidget {
  final Seller seller;

  const SellerDetailsScreen({required this.seller, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SellerDetailsScreenState createState() => _SellerDetailsScreenState();
}

class _SellerDetailsScreenState extends State<SellerDetailsScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _orderIdController = TextEditingController();
  double _userRating = 0.0;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.seller.name,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade100, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: widget.seller.profilePictureUrl.isNotEmpty
                      ? NetworkImage(widget.seller.profilePictureUrl.trim()) // Trim any extraneous whitespace
                      : null,
                  child: widget.seller.profilePictureUrl.isEmpty
                      ? const Icon(Icons.person, color: Colors.white)
                      : null,
                  onBackgroundImageError: (exception, stackTrace) {
                    // Handle image loading error
                    if (kDebugMode) {
                      print('Error loading image: $exception');
                    } // Default placeholder
                  },
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  widget.seller.name,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Location: ${widget.seller.location}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Description:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 46, 125, 50),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.seller.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green.shade600,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle the contact seller action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                      child: const Text(
                        'Contact Seller',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to SellerProductsScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductScreen(sellerId: widget.seller.id),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                      child: const Text(
                        'Products',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Rate this Seller:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 46, 125, 50),
                ),
              ),
              const SizedBox(height: 8),
              RatingBar.builder(
                initialRating: _userRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 30.0,
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
              const SizedBox(height: 24),
              const Text(
                'Order ID:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 46, 125, 50),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _orderIdController,
                decoration: InputDecoration(
                  hintText: 'Enter your order ID here',
                  hintStyle: TextStyle(color: Colors.green.shade400),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding: const EdgeInsets.all(12.0),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Leave a Feedback:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 46, 125, 50),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _feedbackController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter your feedback here',
                  hintStyle: TextStyle(color: Colors.green.shade400),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding: const EdgeInsets.all(12.0),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_userRating > 0 && _orderIdController.text.isNotEmpty) {
                      await _firebaseService.updateSellerRating(
                        widget.seller.id,
                        _userRating,
                        _feedbackController.text,
                        _orderIdController.text,
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context, _userRating);
                    } else {
                      // Handle missing rating or order ID
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please provide a rating and order ID')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  ),
                  child: const Text(
                    'Submit Rating',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
