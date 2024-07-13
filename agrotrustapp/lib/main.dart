import 'package:agrotrustapp/home.dart';
import 'package:agrotrustapp/profile.dart';
import 'package:agrotrustapp/search.dart';
import 'package:agrotrustapp/splash.dart';
import 'package:flutter/material.dart';
 
//import 'package:testagrotrust/splash.dart';
 

//import 'screens/confirmation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Define routes for each screen
  final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    //'/login': (BuildContext context) =>  const LoginPage(),
    '/home': (BuildContext context) => const HomeScreen(),
    '/search': (BuildContext context) => const SearchScreen(),
    //'/product': (BuildContext context) => const ProductScreen(),
    //'/shop': (BuildContext context) => const ShopScreen(),
    //'/cart': (BuildContext context) => const CartScreen(),
    '/profile': (BuildContext context) => const ProfileScreen(),
    //'/checkout': (BuildContext context) => CheckoutScreen(),
    //'/confirmation': (BuildContext context) => ConfirmationScreen(),
    '/splash': (BuildContext context) => const SplashScreen()
  };

   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AgroTrust',
        debugShowCheckedModeBanner: false,
        home:  const SplashScreen(),
        routes: routes);
  }
}