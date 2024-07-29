 import 'package:flutter/material.dart';
import 'models/seller.dart';
import 'details.dart';

class HistoryScreen extends StatelessWidget {
  final List<Seller> clickHistory;

  const HistoryScreen({super.key, required this.clickHistory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Click History'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: clickHistory.length,
        itemBuilder: (context, index) {
          final seller = clickHistory[index];
          return ListTile(
            title: Text(seller.name),
            subtitle: Text(seller.location),
            leading: CircleAvatar(
              backgroundImage: seller.profilePictureUrl.isNotEmpty
                  ? NetworkImage(seller.profilePictureUrl)
                  : const AssetImage('assets/placeholder.png') as ImageProvider,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SellerDetailsScreen(seller: seller),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
