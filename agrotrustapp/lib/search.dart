import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  LatLng? userLocation;
  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterProducts);
    _determinePosition();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return; // Handle permission denial
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      userLocation = LatLng(position.latitude, position.longitude);
    });

    _fetchSellersAndProductsFromFirebase();
  }

  void _fetchSellersAndProductsFromFirebase() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Fetch sellers from Firestore
    QuerySnapshot sellerSnapshot = await firestore.collection('sellers').get();

    List<Map<String, dynamic>> productsWithSellers = [];

    for (var sellerDoc in sellerSnapshot.docs) {
      Map<String, dynamic> sellerData = sellerDoc.data() as Map<String, dynamic>;

      // Fetch products from the subcollection of the current seller
      QuerySnapshot productSnapshot = await sellerDoc.reference.collection('products').get();

      for (var productDoc in productSnapshot.docs) {
        Map<String, dynamic> productData = productDoc.data() as Map<String, dynamic>;

        // Combine product data with seller data
        productsWithSellers.add({
          'name': productData['name'],
          'price': productData['price'],
          'imageUrl': productData['imageUrl'],
          'description': productData['description'],
          'seller': sellerData['name'],
          'address': sellerData['address'],
          'location': LatLng(sellerData['latitude'], sellerData['longitude']),
          'rating': sellerData['rating'],  // Seller rating
        });
      }
    }

    setState(() {
      filteredProducts = productsWithSellers;
    });
  }

  void _filterProducts() {
    final query = searchController.text.toLowerCase();

    setState(() {
      filteredProducts = filteredProducts.where((product) {
        return product['name'].toLowerCase().contains(query) ||
            product['seller'].toLowerCase().contains(query);
      }).toList();
    });
  }

  double _calculateDistance(LatLng location1, LatLng location2) {
    const double earthRadius = 6371.0; // in kilometers

    double dLat = _degreesToRadians(location2.latitude - location1.latitude);
    double dLng = _degreesToRadians(location2.longitude - location1.longitude);

    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degreesToRadians(location1.latitude)) *
            math.cos(_degreesToRadians(location2.latitude)) *
            math.sin(dLng / 2) * math.sin(dLng / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  double _degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  @override
  Widget build(BuildContext context) {
    if (userLocation == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Search')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                searchController.clear();
              },
            )
          ],
        ),
        body: Column(children: <Widget>[
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
                hintText: 'Search for products or sellers',
                prefixIcon: Icon(Icons.search)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (BuildContext context, int index) {
                final product = filteredProducts[index];
                final distance = _calculateDistance(userLocation!, product['location']).toStringAsFixed(2);

                return ListTile(
                  leading: Image.network(
                    product['imageUrl'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price: \$${product['price'].toStringAsFixed(2)}'),
                      Text('Seller: ${product['seller']}'),
                      Text('Address: ${product['address']}'),
                      Text('Description: ${product['description']}'),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Rating: ${product['rating']}'),  // Display seller rating
                      Text('Distance: $distance km'),
                    ],
                  ),
                );
              },
            ),
          )
        ]));
  }
}
