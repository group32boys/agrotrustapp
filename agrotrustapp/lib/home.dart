 import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'services/firebase_storage_service.dart'; // Import Firebase Storage Service
import 'details.dart';
import 'history.dart';
import 'models/seller.dart';
import 'history_entry.dart'; // Import the history entry model
import 'orders.dart';
import 'profile.dart';
import 'services/firebase_service.dart';
import 'services/location_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? _currentPosition;
  List<Seller> _sellers = [];
  final FirebaseService _firebaseService = FirebaseService();
  final FirebaseStorageService _storageService = FirebaseStorageService(); // Initialize the storage service
  final LocationService _locationService = LocationService();
  late final MapController _mapController;
  int _selectedIndex = 0;
  final List<HistoryEntry> _historyEntries = [];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _loadData();
  }

  Future<void> _loadData() async {
    _currentPosition = await _locationService.getCurrentPosition();
    final sellers = await _firebaseService.fetchSellers();

    // Fetch profile picture URLs for all sellers
    final updatedSellers = await Future.wait(sellers.map((seller) async {
      final pictureUrl = await _storageService.getProfilePictureUrl(seller.profilePictureUrl);
      return Seller(
        id: seller.id,
        name: seller.name,
        latitude: seller.latitude,
        longitude: seller.longitude,
        location: seller.location,
        profilePictureUrl: pictureUrl, 
        descripition: seller.descripition, // Set the URL here
      );
    }));

    updatedSellers.sort((a, b) {
      final distanceA = Geolocator.distanceBetween(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        a.latitude,
        a.longitude,
      );
      final distanceB = Geolocator.distanceBetween(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        b.latitude,
        b.longitude,
      );
      return distanceA.compareTo(distanceB);
    });

    setState(() {
      _sellers = updatedSellers;
    });

    _mapController.move(
      LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      13.0,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HistoryScreen(historyEntries: _historyEntries)),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      }
    });
  }

  void _addHistoryEntry(Seller seller) {
    setState(() {
      _historyEntries.add(
        HistoryEntry(
          sellerName: seller.name,
          timestamp: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sellers Near You'),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Center(
                child: Text(
                  'AGROTRUST',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.green),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart, color: Colors.green),
              title: const Text('My Orders'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyOrdersScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history, color: Colors.green),
              title: const Text('History'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryScreen(historyEntries: _historyEntries)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.details, color: Colors.green),
              title: const Text('About Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text('Logout'),
              onTap: () {
                // Handle logout functionality
              },
            ),
          ],
        ),
      ),
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SizedBox(
                  height: 300,
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                      initialZoom: 13.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 30.0,
                            height: 30.0,
                            point: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                            child: const Icon(Icons.my_location, color: Colors.blue),
                          ),
                          ..._sellers.map((seller) => Marker(
                            width: 30.0,
                            height: 30.0,
                            point: LatLng(seller.latitude, seller.longitude),
                            child: const Icon(Icons.location_pin, color: Colors.green),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _sellers.length,
                    itemBuilder: (context, index) {
                      final seller = _sellers[index];
                      final distanceInMeters = Geolocator.distanceBetween(
                        _currentPosition!.latitude,
                        _currentPosition!.longitude,
                        seller.latitude,
                        seller.longitude,
                      );
                      final distanceInKm = distanceInMeters / 1000;
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.green, width: 1.0),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(seller.profilePictureUrl),
                            // Show a placeholder while loading
                            onBackgroundImageError: (error, stackTrace) {
                              // Handle image loading error
                              if (kDebugMode) {
                                print('Error loading image: $error');
                              }
                            },
                          ),
                          title: Text(
                            seller.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${distanceInKm.toStringAsFixed(2)} km away'),
                              Text(
                                seller.location,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          onTap: () {
                            _addHistoryEntry(seller); // Save history on tap
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SellerDetailsScreen(seller: seller),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: 'About Us',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
    );
  }
}
