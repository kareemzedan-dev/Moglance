import 'package:flutter/material.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/features/splash/presentation/views/widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
        color:  Color(0XFF6d1ad3),
        ),
        child: const SplashViewBody(),
      ),
    );
  }
}
