import 'package:agrotrustapp/editprofile.dart';
import 'package:agrotrustapp/home.dart';
import 'package:agrotrustapp/login.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile',
            style: TextStyle(color: Colors.white, fontSize: 24)),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: user != null
          ? FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          'Error loading profile data: ${snapshot.error}'));
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(child: Text('Profile data not found.'));
                }

                final userData = snapshot.data!.data() as Map<String, dynamic>;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: userData['photoURL'] != null &&
                                  userData['photoURL'].isNotEmpty
                              ? NetworkImage(userData['photoURL'])
                              : const AssetImage('assets/default_profile.png')
                                  as ImageProvider,
                          child: userData['photoURL'] == null ||
                                  userData['photoURL'].isEmpty
                              ? const Icon(Icons.camera_alt,
                                  size: 50, color: Colors.white70)
                              : null,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          userData['displayName'] ?? 'No name',
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          userData['email'] ?? 'No email',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(height: 24),
                        ListTile(
                          leading:
                              const Icon(Icons.person, color: Colors.green),
                          title: Text(userData['displayName'] ?? 'No name'),
                          subtitle: const Text('Name'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.email, color: Colors.green),
                          title: Text(userData['email'] ?? 'No email'),
                          subtitle: const Text('Email'),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfilePage()),
                            );
                          },
                          child: const Text('Edit Profile',
                              style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(child: Text('Loading...')),
    );
  }
}
