import 'dart:convert'; // for JSON encoding/decoding
import 'package:shared_preferences/shared_preferences.dart';
import '../models/seller.dart';

class HistoryService {
  static const String _historyKey = 'clickHistory';

  Future<void> saveClickHistory(List<Seller> history) async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = jsonEncode(history.map((seller) => seller.toMap()).toList());
    await prefs.setString(_historyKey, historyJson);
  }

  Future<List<Seller>> loadClickHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_historyKey);
    if (historyJson != null) {
      final List<dynamic> historyList = jsonDecode(historyJson);
      return historyList.map((item) => Seller.fromMap(Map<String, dynamic>.from(item))).toList();
    } else {
      return [];
    }
  }
}
