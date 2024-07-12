  import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
          content: const Text('Type message'),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('images/profile_image.jpg'),
                    radius: 30,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'john.doe@example.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
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
            const Divider(),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {
                // Implement notifications navigation
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/notifications'); // Replace '/notifications' with your notifications route
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('My Orders'),
              onTap: () {
                // Implement orders navigation
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/orders'); // Replace '/orders' with your orders route
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Payments'),
              onTap: () {
                // Implement payments navigation
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/payments'); // Replace '/payments' with your payments route
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Implement logout logic
                Navigator.pop(context); // Close the drawer
                // Replace with logout functionality
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Expanded(
            child: Center(
              child: Text(
                'Map',
                style: TextStyle(
                  color: Color.fromARGB(255, 208, 209, 208),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: 5, // Replace with actual number of sellers
              itemBuilder: (BuildContext context, int index) {
                Color vegetationColor = Colors.green.shade200;

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: const AssetImage('images/sherman.jpg'),
                            backgroundColor: vegetationColor,
                            radius: 30, // Adjust as needed
                          ),
                          const Row(
                            children: <Widget>[
                              Icon(Icons.star, color: Color.fromARGB(255, 230, 207, 6), size: 18),
                              Text(
                                '4.6',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 15, 15, 15),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.location_on, color: Colors.blue, size: 18),
                              Text(
                                '1.2km',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Seller Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Seller Address',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                          const SizedBox(width: 10),
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
                    ],
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
