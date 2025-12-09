import 'package:flutter/material.dart';

class IconMapper {
  static IconData getIcon(String iconName) {
    switch (iconName) {
      case 'note_alt':
        return Icons.note_alt;
      case 'school':
        return Icons.school;
      case 'edit':
        return Icons.edit;
      case 'translate':
        return Icons.translate;
      case 'description':
        return Icons.description;
      case 'slideshow':
        return Icons.slideshow;
      case 'book':
        return Icons.book;
      case 'science':
        return Icons.science;
      case 'code':
        return Icons.code;
      case 'account_tree':
        return Icons.account_tree;
      case 'bar_chart':
        return Icons.bar_chart;
      default:
        return Icons.help_outline; // fallback
    }
  }

 
}
