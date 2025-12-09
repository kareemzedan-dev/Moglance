import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAvatar extends StatelessWidget {
  final String? imagePath;
  final double? radius;
  final String? userName; // 👈 نضيف الاسم عشان ناخد أول حرف منه

  const UserAvatar({
    super.key,
    this.imagePath,
    this.radius = 30,
    required this.userName,
  });

  Color _getBackgroundColor(String name) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
      Colors.brown,
      Colors.pink,
      Colors.cyan,
    ];
    int index = name.codeUnitAt(0) % colors.length;
    return colors[index].shade400;
  }

  @override
  Widget build(BuildContext context) {
    if (imagePath != null && imagePath!.isNotEmpty) {
      return CircleAvatar(
        radius: radius ?? 30.r,
        backgroundImage: imagePath!.startsWith('http')
            ? NetworkImage(imagePath!)
            : FileImage(File(imagePath!)) as ImageProvider,
      );
    } else {
      final displayLetter =
      (userName != null && userName!.isNotEmpty) ? userName![0].toUpperCase() : '?';
      final bgColor = _getBackgroundColor(displayLetter);

      return CircleAvatar(
        radius: radius ?? 30.r,
        backgroundColor: bgColor,
        child: Text(
          displayLetter,
          style: TextStyle(
            color: Colors.white,
            fontSize: radius! * 0.8,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
  }
}
