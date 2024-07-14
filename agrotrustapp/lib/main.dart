 import 'package:agrotrustapp/home.dart';
import 'package:agrotrustapp/profile.dart';
import 'package:agrotrustapp/search.dart';
import 'package:flutter/material.dart';
import 'package:agrotrustapp/product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Define routes for each screen
  final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    '/home': (BuildContext context) => const HomeScreen(),
    '/search': (BuildContext context) => const SearchScreen(),
    '/product': (BuildContext context) => const ProductScreen(),
    '/profile': (BuildContext context) => const ProfileScreen(),
  };

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroTrust',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      routes: routes,
    );
  }
}
