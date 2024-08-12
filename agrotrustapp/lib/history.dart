import 'package:flutter/material.dart';

// Define a data model for Order history
class Order {
  final String itemName;
  final String date;
  final String status;

  Order({
    required this.itemName,
    required this.date,
    required this.status,
  });
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example order history data
    final List<Order> orders = [
      Order(itemName: 'Weed Master', date: '2024-07-15', status: 'Completed'),
      Order(itemName: 'Tick Burn', date: '2024-07-14', status: 'Pending'),
      Order(itemName: 'Arphid killer', date: '2024-07-13', status: 'Shipped'),
      // Add more Order objects here
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return HistoryItem(
              itemName: order.itemName,
              date: order.date,
              status: order.status,
            );
          },
        ),
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final String itemName;
  final String date;
  final String status;

  const HistoryItem({
    super.key,
    required this.itemName,
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
        title: Text('Item: $itemName', style: const TextStyle(color: Colors.green)),
        subtitle: Text('Date: $date\nStatus: $status', style: TextStyle(color: Colors.green.shade700)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.green),
        onTap: () {
          // Handle item tap if needed
        },
      ),
    );
  }
}
