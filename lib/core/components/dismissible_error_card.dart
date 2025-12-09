import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum MessageType { success, error, waiting }

class DismissibleMessageCard extends StatelessWidget {
  final String message;
  final VoidCallback onDismiss;
  final MessageType type;

  const DismissibleMessageCard({
    super.key,
    required this.message,
    required this.onDismiss,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    if (message.isEmpty) return const SizedBox.shrink();

    // تحديد اللون حسب النوع
    final color = switch (type) {
      MessageType.error => Colors.red,
      MessageType.success => Colors.green,
      MessageType.waiting => Colors.blue,
    };

    final bgColor = switch (type) {
      MessageType.error => Colors.red.shade100,
      MessageType.success => Colors.green.shade100,
      MessageType.waiting => Colors.blue.shade100,
    };

    final icon = switch (type) {
      MessageType.error => Icons.error_outline,
      MessageType.success => Icons.check_circle,
      MessageType.waiting => Icons.hourglass_top,
    };

    return Card(
      color: bgColor,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: color),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: color, fontWeight: FontWeight.w500,fontSize: 14.sp),
              ),
            ),
            GestureDetector(
              onTap: onDismiss,
              child: Icon(Icons.close, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

void showTemporaryMessage(
  BuildContext context,
  String message,
  MessageType type, {
  int durationSeconds = 3,
}) {
  final overlay = Overlay.of(context);
  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 20,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: DismissibleMessageCard(
          message: message,
          type: type,
          onDismiss: () {
            entry.remove();
          },
        ),
      ),
    ),
  );

  overlay.insert(entry);

  Future.delayed(Duration(seconds: durationSeconds), () {
    if (entry.mounted) entry.remove();
  });
}
