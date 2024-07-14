<<<<<<< HEAD
   import 'package:agrotrustapp/home.dart';
import 'package:agrotrustapp/login.dart';
=======
 import 'package:agrotrustapp/home.dart';
//import 'package:agrotrustapp/login.dart';
>>>>>>> main
import 'package:agrotrustapp/profile.dart';
import 'package:agrotrustapp/search.dart';
//import 'package:agrotrustapp/splash.dart';
import 'package:firebase_core/firebase_core.dart';  // Import Firebase core
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Ensure Flutter is initialized
  await Firebase.initializeApp();  // Initialize Firebase

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Define routes for each screen
  final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
<<<<<<< HEAD
    '/login': (BuildContext context) =>  const LoginPage(),
=======
>>>>>>> main
    '/home': (BuildContext context) => const HomeScreen(),
    '/search': (BuildContext context) => const SearchScreen(),
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
<<<<<<< HEAD
        home:  const LoginPage(),
=======
        home: const HomeScreen(),
>>>>>>> main
        routes: routes);
  }
}
