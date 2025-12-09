import 'package:flutter/material.dart';
import '../cache/shared_preferences.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const _languageKey = "app_language";

  static Future<void> changeLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, code);
    // لو انت عايز تغير الـ locale فوراً في التطبيق ممكن تعمل notify هنا
  }

  static Future<String> getCurrentLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? "ar"; // عربي افتراضي
  }
}
