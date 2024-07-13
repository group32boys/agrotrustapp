import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  
  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_circle,
                size: 150,
                ),
              // welcome message
              const Text(
                ' WELCOME!\n We connect Farmers to trusted Agrochemical Sellers',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ), // text style
              ), // text

              // email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ), // input decoration
                  ), // text field
                ), // container
              ), // padding

              const SizedBox(height: 20),

              // password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ), // input decoration
                  ), // text field
                ), // container
              ), // padding

              const SizedBox(height: 10),

              // login button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ), // box decoration
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ), // text style
                    ), // text
                  ), // center
                ), // container
              ), // padding

              const SizedBox(height: 25),

              // not a member? register now
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ), // text style
                  ), // text

                  Text(
                    '  Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ), // text style
                  ), // text
                ], // row children
              ), // row
            ], // column children
          ), // column
        ), // center
      ), // safe area
    ); // scaffold
  } // build
}
