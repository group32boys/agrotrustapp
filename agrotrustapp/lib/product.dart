import 'package:flutter/material.dart';
import 'package:agrotrustapp/models/product_model.dart';
import 'package:agrotrustapp/services/firebase_service.dart';
import 'package:agrotrustapp/product_details.dart';

class ProductScreen extends StatelessWidget {
  final String sellerId;

  const ProductScreen({super.key, required this.sellerId});

  Future<List<Product>> _fetchProducts() async {
    final service = FirebaseService();
    final products = await service.fetchProducts(sellerId);
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),

        

        backgroundColor: Colors.green,


        elevation: 0,
      ),
      body: FutureBuilder<List<Product>>(
        future: _fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.red)));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found.', style: TextStyle(fontSize: 18, color: Colors.grey)));
          }

          final products = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: product.image.isNotEmpty
                      ? SizedBox(
                          width: 80,
                          height: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product.image,

                            ),
                          ),
                        )
                      : Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image, size: 40, color: Colors.grey),
                        ),
                  title: Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(
                    '${product.description}\n${product.units}gms',
                    style: const TextStyle(color: Colors.black54),
                  ),
                  trailing: Text(


                    ' Ugx ${product.price.toStringAsFixed(2)}',


                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: product),
                      ),
                    );
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
