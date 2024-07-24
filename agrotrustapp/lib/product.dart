import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required String sellerId});

  @override
  Widget build(BuildContext context) {
    // Sample product data
    final List<Map<String, String>> products = [
      {
        'name': 'Cypher-lacer',
        'image': 'images/Cyper-Lacer.jpg',
        'price': '\$10',
        'description': 'An advanced cypher-lacer for all your crop pest control.'
      },
      {
        'name': 'Rocket',
        'image': 'images/Roket-1.jpg',
        'price': '\$20',
        'description': 'A powerful rocket for your insect control and pollinators attraction.'
      },
      {
        'name': 'Troban',
        'image': 'images/Troban-48-EC.jpg',
        'price': '\$30',
        'description': 'Troban 48 EC, a reliable tool for crop pest control.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.asset(
                    product['image']!,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product['name']!,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    product['price']!,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product['description']!,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle order button press
                    },
                    child: const Text('Order'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
