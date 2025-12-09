import 'package:flutter/material.dart';
import '../services/language_service.dart';
import '../cache/shared_preferences.dart';
import '../utils/strings_manager.dart';

class LanguageNotifier extends ValueNotifier<Locale> {
  LanguageNotifier(Locale value) : super(value);

  Future<void> changeLanguage(String code) async {
    await LanguageService.changeLanguage(code); // لو عندك service
    value = Locale(code); // هيفيد MaterialApp rebuild
    await SharedPrefHelper.setString(StringsManager.languageCodeKey, code); // حفظ اللغة
  }

  String get currentLanguage => value.languageCode;
}
