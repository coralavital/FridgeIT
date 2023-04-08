// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fridge_it/theme/theme_colors.dart';
import 'package:fridge_it/widgets/small_text.dart';

import '../utils/dimensions.dart';

class CustomContainer extends StatefulWidget {
  final String title;
  final String image;
  String? expiriation_date;

  CustomContainer({
    super.key,
    required this.title,
    required this.image,
    this.expiriation_date,
  });

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 9),
      child: Container(
        width: Dimensions.size130,
        padding: EdgeInsets.all(Dimensions.size15),
        decoration: BoxDecoration(
          color: ThemeColors().main.withOpacity(0.5),
          borderRadius: BorderRadius.circular(Dimensions.size20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SmallText(
                text: widget.title,
                color: Colors.black54,
                size: Dimensions.size10,
                fontWeight: FontWeight.bold),
            SizedBox(
              height: 15,
            ),
            Image.network(
              widget.image.toString(),
              height: Dimensions.size70,
              width: Dimensions.size70,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                widget.expiriation_date != null
                    ? Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  width: 6,
                ),
                widget.expiriation_date != null
                    ? Text(
                        widget.expiriation_date!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      )
                    : SizedBox()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
