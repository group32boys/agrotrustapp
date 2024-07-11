import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  final List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
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
                  hintText: 'Search for sellers', prefixIcon: Icon(Icons.search)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: markers.length,
              itemBuilder: (BuildContext context, int index) {
                // Show the list of filtered sellers here
                return const ListTile(
                  leading:
                   Icon(Icons.store_mall_directory),
                  title: Text('Seller Name'),
                  subtitle: Text('Seller address'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Rating: 4.6'),
                      Text('Distance: 1.2km')
                    ],
                  ),
                );
              }),
          )
        ]));
  }
}
