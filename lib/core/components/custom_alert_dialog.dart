import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String? lottieAsset;
  final IconData? leadingIcon;
  final Color? leadingIconColor;
  final String? warningLabel;
  final Color? warningColor;
  final String positiveButtonText;
  final VoidCallback onPositivePressed;
  final String? negativeButtonText;
  final VoidCallback? onNegativePressed;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.positiveButtonText,
    required this.onPositivePressed,
    this.lottieAsset,
    this.leadingIcon,
    this.leadingIconColor,
    this.warningLabel,
    this.warningColor,
    this.negativeButtonText,
    this.onNegativePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      elevation: 10,
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (lottieAsset != null)
              Center(
                child: Lottie.asset(
                  lottieAsset!,
                  width: 100,
                  height: 100,
                ),
              ),
            const SizedBox(height: 20),
            Row(
              children: [
                if (leadingIcon != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (leadingIconColor ?? Colors.orange).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      leadingIcon,
                      color: leadingIconColor ?? Colors.orange,
                      size: 28,
                    ),
                  ),
                if (leadingIcon != null) const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (warningLabel != null)
              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: (warningColor ?? Colors.red).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: (warningColor ?? Colors.red).withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: warningColor ?? Colors.red.shade600,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      warningLabel!,
                      style: TextStyle(
                        color: warningColor ?? Colors.red.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            Text(
              content,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Colors.grey.shade700,
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                if (negativeButtonText != null && onNegativePressed != null)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onNegativePressed,
                      style: OutlinedButton.styleFrom(
                        padding:
                        const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: Colors.grey.shade400),
                      ),
                      child: Text(
                        negativeButtonText!,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                if (negativeButtonText != null && onNegativePressed != null)
                  const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onPositivePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      padding:
                      const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      positiveButtonText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
