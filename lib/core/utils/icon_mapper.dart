import 'package:flutter/material.dart';

/// دالة لتحويل اسم الأيقونة (String) إلى IconData
IconData getIconFromString(String iconName) {
  switch (iconName) {
    case 'menu_book':
      return Icons.menu_book;
    case 'description':
      return Icons.description;
    case 'account_tree':
      return Icons.account_tree;
    case 'translate':
      return Icons.translate;
    case 'notes':
      return Icons.notes;
    case 'science':
      return Icons.science;
    case 'slideshow':
      return Icons.slideshow;
    case 'analytics':
      return Icons.analytics;
    case 'spellcheck':
      return Icons.spellcheck;
    case 'work':
      return Icons.work;
    case 'code':
      return Icons.code;
    case 'school':
      return Icons.school;
    case 'support_agent':
      return Icons.support_agent;
    case 'brush':
      return Icons.brush;
    case 'engineering':
      return Icons.engineering;
    case 'account_balance':
      return Icons.account_balance;
    default:
      return Icons.help_outline; // أيقونة افتراضية لو الاسم غلط
  }
}
