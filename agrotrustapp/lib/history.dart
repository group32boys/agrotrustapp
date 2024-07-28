 // history.dart
// ignore_for_file: unnecessary_string_interpolations

import 'package:agrotrustapp/history_entry.dart';
import 'package:flutter/material.dart';


class HistoryScreen extends StatelessWidget {
  final List<HistoryEntry> historyEntries;

  const HistoryScreen({super.key, required this.historyEntries});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Colors.green,
      ),
      body: historyEntries.isEmpty
          ? const Center(child: Text('No history available'))
          : ListView.builder(
              itemCount: historyEntries.length,
              itemBuilder: (context, index) {
                final entry = historyEntries[index];
                return ListTile(
                  title: Text(entry.sellerName),
                  subtitle: Text(
                    '${entry.timestamp.toLocal().toString()}',
                  ),
                );
              },
            ),
    );
  }
}
