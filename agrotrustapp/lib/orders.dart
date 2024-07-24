 import 'package:flutter/material.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            // Example order items; replace with your actual data
            OrderItem(orderId: '12345', date: '2024-07-15', total: '100.00 USD'),
            OrderItem(orderId: '67890', date: '2024-07-14', total: '50.00 USD'),
            OrderItem(orderId: '54321', date: '2024-07-13', total: '75.00 USD'),
            // Add more OrderItem widgets here
          ],
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String orderId;
  final String date;
  final String total;

  const OrderItem({super.key, 
    required this.orderId,
    required this.date,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.green.shade300),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text('Order ID: $orderId', style: const TextStyle(color: Colors.green)),
        subtitle: Text('Date: $date\nTotal: $total', style: TextStyle(color: Colors.green.shade700)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.green),
        onTap: () {
          // Handle item tap if needed
        },
      ),
    );
  }
}
