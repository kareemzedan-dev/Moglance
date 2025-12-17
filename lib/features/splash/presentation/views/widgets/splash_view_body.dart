import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskly/core/utils/assets_manager.dart';

import '../../../../../config/routes/routes_manager.dart';
import '../../../../../core/cache/shared_preferences.dart';
import '../../../../../core/utils/strings_manager.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with TickerProviderStateMixin {

  late AnimationController nameCtrl;
  late AnimationController fishingCtrl;
  late AnimationController bagCtrl;

  late Animation<double> nameAnim;
  late Animation<double> fishingAnim;
  late Animation<double> bagAnim;
  var token = SharedPrefHelper.getString(StringsManager.tokenKey);
  var role = SharedPrefHelper.getString(StringsManager.roleKey);

  @override
  void initState() {
    super.initState();

    nameCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    nameAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.1), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 0.95), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(parent: nameCtrl, curve: Curves.easeOut));

    fishingCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    fishingAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.1), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 0.95), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(parent: fishingCtrl, curve: Curves.easeOut));

    bagCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    bagAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.1), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 0.95), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(parent: bagCtrl, curve: Curves.easeOut));

    _startAnimationSequence();
  }

  Future<void> _startAnimationSequence() async {
    // 1) name
    await nameCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 500));

    // 2) fishing_tool
    await fishingCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 500));

    // 3) bag → وبعدها نعمل navigate
    await bagCtrl.forward();

    // لما آخر أنيميشن يخلص → نروح للصفحة المناسبة
    Future.delayed(const Duration(milliseconds: 300), () {
      _navigate();
    });
  }


  @override
  void dispose() {
    nameCtrl.dispose();
    fishingCtrl.dispose();
    bagCtrl.dispose();
    super.dispose();
  }
  void _navigate() {
    if (!mounted) return;

    if (token != null) {
      Navigator.pushReplacementNamed(
        context,
        role == StringsManager.freelancerRole
            ? RoutesManager.freelancerHome
            : RoutesManager.clientHome,
      );
    } else {
      Navigator.pushReplacementNamed(context, RoutesManager.welcome);
    }
  }
  @override
  Widget build(BuildContext context) {





    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [

          /// fishing_tool
          AnimatedBuilder(
            animation: fishingAnim,
            builder: (_, child) {
              return Opacity(
                opacity: fishingCtrl.value,
                child: Transform.scale(
                  scale: fishingAnim.value,
                  child: child,
                ),
              );
            },
            child: SvgPicture.asset(
              Assets.fishing_tool,
              width: 500.w,
              height: 500.w,
            ),
          ),

          /// bag
          AnimatedBuilder(
            animation: bagAnim,
            builder: (_, child) {
              return Opacity(
                opacity: bagCtrl.value,
                child: Transform.scale(
                  scale: bagAnim.value,
                  child: child,
                ),
              );
            },
            child: SvgPicture.asset(
              Assets.bag,
              width: 500.w,
              height: 500.w,
            ),
          ),

          /// name — يظهر الأول
          AnimatedBuilder(
            animation: nameAnim,
            builder: (_, child) {
              return Opacity(
                opacity: nameCtrl.value,
                child: Transform.scale(
                  scale: nameAnim.value,
                  child: child,
                ),
              );
            },
            child: SvgPicture.asset(
              Assets.name,
              width: 400.w,
              height: 400.w,
            ),
          ),
        ],
      ),
    );
  }
}
