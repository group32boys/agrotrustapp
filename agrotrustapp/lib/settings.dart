import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Dark Mode'),
              trailing: Switch.adaptive(
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme(value);
                },
              ),
            ),
            ListTile(
              title: const Text('Enable Location Access'),
              trailing: Switch.adaptive(
                value: themeProvider.isLocationAccessEnabled,
                onChanged: (value) {
                  themeProvider.toggleLocationAccess(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
