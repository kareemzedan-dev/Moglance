import 'package:flutter/material.dart';

class GradientOverlay extends StatelessWidget {
  const GradientOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.4, 0.7, 1.0],
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.6),
            Colors.black,
          ],
        ),
      ),
    );
  }
}