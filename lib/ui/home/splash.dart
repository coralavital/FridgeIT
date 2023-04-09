// imports
import 'package:flutter/material.dart';
import '../../theme/theme_colors.dart';
import 'package:flutter/services.dart';
import '../../check_user_state.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../../utils/dimensions.dart';


// SplashScreen class
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );
    Timer(
      const Duration(seconds: 4),
      () => Get.off(
        const CheckUserState(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors().background,
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          systemNavigationBarColor: ThemeColors().background,
          statusBarColor: ThemeColors().background,
        ),
      ),
      backgroundColor: ThemeColors().background,
      body: ScaleTransition(
        scale: animation,
        child: Padding(
          padding: EdgeInsets.only(bottom: Dimensions.size150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/icons/splash_icon.png',
                width: double.maxFinite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
