import 'package:flutter/material.dart';
import 'package:agrotrustapp/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProductDetailScreen extends StatelessWidget {
  final String productId;
  final String sellerId;

  const ProductDetailScreen({super.key, required this.productId, required this.sellerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.green[700],
        elevation: 5,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body:FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('sellers').doc('sellerId').collection('products').doc(productId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }
          final product = Product.fromDocument(snapshot.data!);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  product.image,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 8.0),
                Text(
                  product.description,
                  style: const TextStyle(fontSize:16),
                ),
                  Text('Units: ${product.units}gms'),
              ],
            ),
          );
        },
      ),
    ); 
  }

}

