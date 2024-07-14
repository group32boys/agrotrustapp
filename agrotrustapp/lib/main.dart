 import 'package:agrotrustapp/home.dart';
//import 'package:agrotrustapp/login.dart';
import 'package:agrotrustapp/profile.dart';
import 'package:agrotrustapp/search.dart';
//import 'package:agrotrustapp/splash.dart';
import 'package:firebase_core/firebase_core.dart';  // Import Firebase core
import 'package:flutter/material.dart';

import 'package:agrotrustapp/product.dart';
//import 'package:testagrotrust/splash.dart';
 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Ensure Flutter is initialized
  await Firebase.initializeApp();  // Initialize Firebase

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Define routes for each screen
  final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    '/home': (BuildContext context) => const HomeScreen(),
    '/search': (BuildContext context) => const SearchScreen(),

    '/product': (BuildContext context) => const ProductScreen(),
    //'/shop': (BuildContext context) => const ShopScreen(),
    //'/cart': (BuildContext context) => const CartScreen(),
    '/profile': (BuildContext context) => const ProfileScreen(),
    //'/login': (BuildContext context) => const LoginPage(),
    //'/splash': (BuildContext context) => const SplashScreen(),
    // ignore: equal_keys_in_map
    //'/search': (BuildContext context) => const SearchScreen(),
    //'/product': (BuildContext context) => const ProductScreen(),
  };

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AgroTrust',
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
        routes: routes);
  }
}
