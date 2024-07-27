import 'package:flutter/material.dart';
import 'package:agrotrustapp/models/product_model.dart';
import 'package:flutter/gestures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProductScreen extends StatelessWidget {
  final String sellerId;

  const ProductScreen({super.key, required this.sellerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deals in Products Below'),
        backgroundColor: Colors.green[700],
        elevation: 5,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').where('sellerId', isEqualTo: sellerId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }
          final products = snapshot.data!.docs;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                margin: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Image.network(
                    product['image'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product['name']),
                  subtitle: Text('\$${product['price']}'),

                  onTap: (){
                  //Navigate to product details
                  },
                ), 
              );
            },
          );
        },
      ), 
    );
  }
}

