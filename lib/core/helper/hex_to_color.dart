import 'dart:ui';

Color hexToColor(String hexCode) {
  hexCode = hexCode.replaceAll('#', '');
  if (hexCode.length == 6) {
    hexCode = 'FF$hexCode';
  }
  return Color(int.parse(hexCode, radix: 16));
}