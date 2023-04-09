// ignore_for_file: prefer_const_constructors
import 'package:fridge_it/theme/theme_colors.dart';
import 'package:fridge_it/utils/dimensions.dart';
import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final dynamic onTap;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.size20),
        child: Container(
          height: Dimensions.size50,
          width: Dimensions.size170,
          decoration: BoxDecoration(
            color: ThemeColors().main,
            borderRadius: BorderRadius.circular(Dimensions.size15),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.size15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
