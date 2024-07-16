import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            // Example history items; replace with your actual data
            HistoryItem(orderId: '12345', date: '2024-07-15', status: 'Completed'),
            HistoryItem(orderId: '67890', date: '2024-07-14', status: 'Pending'),
            HistoryItem(orderId: '54321', date: '2024-07-13', status: 'Shipped'),
            // Add more HistoryItem widgets here
          ],
        ),
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final String orderId;
  final String date;
  final String status;

  const HistoryItem({super.key, 
    required this.orderId,
    required this.date,
    required this.status,
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
        subtitle: Text('Date: $date\nStatus: $status', style: TextStyle(color: Colors.green.shade700)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.green),
        onTap: () {
          // Handle item tap if needed
        },
      ),
    );
  }
}
