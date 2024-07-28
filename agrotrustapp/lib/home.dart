 import 'package:agrotrustapp/aboutus.dart';
import 'package:agrotrustapp/login.dart';
import 'package:agrotrustapp/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'details.dart';
import 'history.dart';
import 'models/seller.dart';
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
  String _selectedSortOption = 'location';
  int _selectedIndex = 0;
  late MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getCurrentLocation();
    _loadData();
  }

  Future<void> _getCurrentLocation() async {
    _currentPosition = await LocationService().getCurrentPosition();
    setState(() {});
  }

  Future<void> _loadData() async {
    _sellers = await _firebaseService.fetchSellers();
    _sortSellers(_sellers);
    setState(() {});
  }

  void _sortSellers(List<Seller> sellers) {
    if (_selectedSortOption == 'location') {
      sellers.sort((a, b) {
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
    } else if (_selectedSortOption == 'rating') {
      sellers.sort((a, b) => b.rating.compareTo(a.rating));
    }
  }

  void _onSortOptionChanged(String? newValue) {
    setState(() {
      _selectedSortOption = newValue!;
      _sortSellers(_sellers);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (_selectedIndex) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HistoryScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
    }
  }

  Future<void> _refreshSellers() async {
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sellers Near You'),
        backgroundColor: Colors.green,
        actions: [
          DropdownButton<String>(
            value: _selectedSortOption,
            icon: const Icon(Icons.sort, color: Colors.white),
            dropdownColor: Colors.green,
            items: const [
              DropdownMenuItem(
                value: 'location',
                child: Text('Sort by Location'),
              ),
              DropdownMenuItem(
                value: 'rating',
                child: Text('Sort by Rating'),
              ),
            ],
            onChanged: _onSortOptionChanged,
          ),
        ],
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
              leading: const Icon(Icons.history, color: Colors.green),
              title: const Text('History'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.green),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.details, color: Colors.green),
              title: const Text('About Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutusScreen()),
                );
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text('Logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
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
                  child: RefreshIndicator(
                    onRefresh: _refreshSellers,
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
                        final distanceInKm = distanceInMeters / 1000; // Convert meters to kilometers
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
                              backgroundImage: seller.profilePictureUrl.isNotEmpty
                                  ? NetworkImage(seller.profilePictureUrl)
                                  : const AssetImage('assets/placeholder.png') as ImageProvider,
                            ),
                            title: Text(
                              seller.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${distanceInKm.toStringAsFixed(2)} km away',
                                ),
                                Text(
                                  seller.location,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: seller.rating,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 20.0,
                                      ignoreGestures: true,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      seller.rating.toStringAsFixed(1),
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            onTap: () async {
                              final updatedRating = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SellerDetailsScreen(seller: seller),
                                ),
                              );

                              if (updatedRating != null) {
                                setState(() {
                                  seller.rating = updatedRating;
                                });
                              }
                            },
                          ),
                        );
                      },
                    ),
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
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
    );
  }
}
