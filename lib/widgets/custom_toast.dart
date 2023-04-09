import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import '../theme/theme_colors.dart';
import '../utils/dimensions.dart';

class CustomToast {
  FToast fToast = FToast();
  late Widget toast;

  String message;
  BuildContext context;
  CustomToast({required this.message, required this.context});

  showCustomToast() {
    fToast.init(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: ThemeColors().cream,
      ),
      margin: EdgeInsets.only(bottom: Dimensions.size40),
      child: Text(
        message,
        style: TextStyle(
            color: ThemeColors().main,
            fontSize: Dimensions.size10,
            fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );

    fToast.showToast(
        child: toast,
        toastDuration: const Duration(seconds: 3),
        gravity: ToastGravity.BOTTOM);
    return toast;
  }
}
