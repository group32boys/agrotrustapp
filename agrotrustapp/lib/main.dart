import 'package:agrotrustapp/aboutus.dart';
import 'package:agrotrustapp/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart'; // Import the firebase_options.dart file
//import 'platform_helper.dart'; // Import the platform helper

import 'package:agrotrustapp/home.dart';
import 'package:agrotrustapp/login.dart';
import 'package:agrotrustapp/product.dart';
//import 'package:agrotrustapp/profile.dart';
import 'package:agrotrustapp/search.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Define routes for each screen
  final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    '/home': (BuildContext context) => const HomeScreen(),
    '/search': (BuildContext context) => const SearchScreen(),
    '/product': (BuildContext context) => const ProductScreen(sellerId: ''),
    //'/profile': (BuildContext context) => const ProfileScreen(),
    '/login': (BuildContext context) => const LoginPage(),
      '/about': (BuildContext context) => const AboutusScreen(),
  };

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroTrust',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: routes,
    );
  }
}
