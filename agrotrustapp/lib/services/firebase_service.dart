 import 'package:agrotrustapp/models/seller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Seller>> fetchSellers() async {
    final snapshot = await _firestore.collection('sellers').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Seller(
        id: doc.id,
        name: data['name'],
        latitude: data['latitude'],
        longitude: data['longitude'],
        profilePictureUrl: data['profilePictureUrl'], 
        descripition: data['description'], 
        location: data['location'],
      );
    }).toList();
  }
}
