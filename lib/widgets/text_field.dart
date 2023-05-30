// ignore_for_file: prefer_const_constructors
import 'package:fridge_it/theme/theme_colors.dart';
import 'package:fridge_it/utils/dimensions.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final dynamic onSubmitted;

  int maxLength;

  TextFieldWidget(
      {super.key,
      required this.controller,
      required this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.onSubmitted,
      this.maxLength = 50});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          left: Dimensions.size20,
          right: Dimensions.size20,
          top: Dimensions.size10,
        ),
        child: Column(
          children: [
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ThemeColors().main.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(Dimensions.size15),
                ),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  obscureText: hintText == 'Password' ? true : false,
                  controller: controller,
                  textCapitalization: TextCapitalization.words,
                  cursorColor: ThemeColors().green2,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hoverColor: ThemeColors().background,
                    hintText: hintText,
                    prefixIcon: prefixIcon,
                  ),
                )),
          ],
        ));
  }
}
