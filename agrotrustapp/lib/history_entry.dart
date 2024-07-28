// models/history_entry.dart
import 'package:equatable/equatable.dart';

class HistoryEntry extends Equatable {
  final String sellerName;
  final DateTime timestamp;

  const HistoryEntry({required this.sellerName, required this.timestamp});

  @override
  List<Object?> get props => [sellerName, timestamp];
}
