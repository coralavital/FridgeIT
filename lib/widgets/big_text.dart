// imports
import 'package:flutter/material.dart';
import '../utils/dimensions.dart';

// BigText class
class BigText extends StatelessWidget {
  Color? color;
  String text;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  String? fontFamily;
  double size;
  TextOverflow overflow;
  BigText({
    Key? key,
    this.fontWeight = FontWeight.w500,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.fontFamily = 'Poppins',
    this.size = 0,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 10,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight ?? FontWeight.w500,
        fontFamily: fontFamily,
        fontSize: size == 0 ? Dimensions.size20 : size,
      ),
    );
  }
}