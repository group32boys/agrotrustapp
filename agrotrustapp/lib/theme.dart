import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool isLocationAccessEnabled = true;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleLocationAccess(bool isEnabled) {
    isLocationAccessEnabled = isEnabled;
    notifyListeners();
  }
}
