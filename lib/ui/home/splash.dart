// imports
import 'package:flutter/material.dart';
import '../../theme/theme_colors.dart';
import 'package:flutter/services.dart';
import '../../check_user_state.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import 'package:get/get.dart';
import 'dart:async';


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
      appBar: AppBar(systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            systemNavigationBarColor: ThemeColors().white,
            statusBarColor: ThemeColors().white,
          ),),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                'assets/icons/Icon-FridgeIT.png',
                width: Dimensions.size30 * 7,
              ),
            ),
          ),
          SizedBox(height: Dimensions.size15,),
          BigText(text: 'Your fridge never been smarter'),
        ],
      ),
    );
  }
}