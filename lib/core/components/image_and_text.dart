import 'package:flutter/material.dart';
import 'package:taskly/core/utils/colors_manger.dart';

class ImageAndText extends StatelessWidget {
  ImageAndText({
    super.key,
    required this.image,
    required this.text,
    this.istrending = false,
  });
  String image, text;
  bool istrending = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.contain,
                ),
                color: const Color(0xFFF5F5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            istrending
                ? Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.add, color: ColorsManager.primary),
                  ),
                )
                : Container(),
          ],
        ),
        const SizedBox(height: 6),
        istrending
            ? Text(
              text,
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.70),
                fontSize: 12,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.visible,
            )
            : Text(
              text,
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.85),
                fontSize: 12,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
      ],
    );
  }
}
