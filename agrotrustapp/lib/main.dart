

import 'dart:io';

import 'package:agrotrustapp/home.dart';
import 'package:agrotrustapp/product.dart';
//import 'package:agrotrustapp/login.dart';

 

import 'package:agrotrustapp/profile.dart';
import 'package:agrotrustapp/search.dart';
//import 'package:agrotrustapp/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
Platform.isAndroid?
await Firebase.initializeApp(
  options: const FirebaseOptions(
   apiKey: "AIzaSyBWIjZEksSC2ATG5gpF_Kq7_67t",
   appId: "1:258868804337:android:367fa7057204c7dc178750",
   messagingSenderId: "258868804337",
   projectId: "agrotrust-18dc8") 
  )
    
    :await Firebase.initializeApp();
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
