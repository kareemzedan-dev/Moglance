import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  String _currentTheme = "Light"; // default

  String get currentTheme => _currentTheme;

  ThemeNotifier() {
    _loadTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _currentTheme = prefs.getString('app_theme') ?? "Light";
    notifyListeners();
  }

  void setTheme(String theme) async {
    _currentTheme = theme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_theme', theme);
    notifyListeners();
  }
}
