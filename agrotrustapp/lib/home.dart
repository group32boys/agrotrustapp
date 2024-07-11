 import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
  




class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Marker> markers = [];

  void _handleShopAction(BuildContext context, int index) {
    // Replace with your actual shop logic, e.g., navigate to shop screen
    if (kDebugMode) {
      print('Shop button pressed for index $index');
    }
    // Example: navigate to shop screen
    Navigator.pushNamed(context, '/shop'); // Replace '/shop' with your shop route
  }

  void _handleSendMessage(BuildContext context, int index) {
    // Replace with your actual send message logic
    if (kDebugMode) {
      print('Send message button pressed for index $index');
    }
    // Example: show dialog or navigate to message screen
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send Message'),
          content: const Text('type message'),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _handleSearch() {
    // Replace with your actual search action
    if (kDebugMode) {
      print('Search button pressed');
    }
    // Example: navigate to search screen or perform search functionality
    Navigator.pushNamed(context, '/search'); // Replace '/search' with your search route
  }

  void _navigateToPage(int index) {
    // Handle navigation to different pages based on index
    switch (index) {
      case 0:
        // Navigate to home screen (already on home screen)
        break;
      case 1:
        // Replace with your actual favorites screen navigation logic
        if (kDebugMode) {
          print('Navigate to Favorites');
        }
        Navigator.pushNamed(context, '/favorites'); // Replace '/favorites' with your favorites route
        break;
      case 2:
        // Replace with your actual profile screen navigation logic
        if (kDebugMode) {
          print('Navigate to Profile');
        }
        Navigator.pushNamed(context, '/profile'); // Replace '/profile' with your profile route
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Agrotrust'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _handleSearch,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Implement settings navigation
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/settings'); // Replace '/settings' with your settings route
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                // Implement help navigation
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/help'); // Replace '/help' with your help route
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          const Expanded(
            // Rechild: const Center(
                child: Text(
                  'map',
                  style: TextStyle(
                    color: Color.fromARGB(255, 208, 209, 208),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
            
          ))),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: 5, // Replace with actual number of sellers
              itemBuilder: (BuildContext context, int index) {
                // Replace with actual asset paths and seller details
                Color vegetationColor = Colors.green.shade200;

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: CircleAvatar(
                      backgroundImage: const AssetImage('images/sherman.jpg'),
                      backgroundColor: vegetationColor,
                      radius: 30, // Adjust as needed
                    ),
                    title: const Text(
                      'Seller Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Seller Address'),
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            Icon(Icons.star, color: Colors.yellow),
                            SizedBox(width: 5),
                            Text('Rating: 4.6'),
                            SizedBox(width: 10),
                            Icon(Icons.location_on, color: Colors.blue),
                            SizedBox(width: 5),
                            Text('Distance: 1.2km'),
                          ],
                        ),
                      ],
                    ),
                    trailing: Wrap(
                      spacing: 5,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            _handleShopAction(context, index);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          child: const Text('Shop House'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _handleSendMessage(context, index);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text('Contact'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (int index) {
          // Handle navigation to different pages based on index
          _navigateToPage(index);
        },
      ),
    );
  }
}
