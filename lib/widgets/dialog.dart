import 'package:fridge_it/widgets/small_text.dart';
import 'package:fridge_it/utils/dimensions.dart';
import 'package:fridge_it/widgets/big_text.dart';
import 'package:flutter/material.dart';
import '../theme/theme_colors.dart';


class CustomDialog extends StatelessWidget {
  String title;
  String message;

  CustomDialog({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThemeColors().background,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                alignment: Alignment.topRight,
                onPressed: () => Navigator.pop(context, 'Cancel'),
                icon: const Icon(Icons.close_rounded),
                color: ThemeColors().black,
                iconSize: Dimensions.size20,
              ),
            ],
          ),
          BigText(
            text: title,
            size: Dimensions.size30,
            fontWeight: FontWeight.w800,
            color: ThemeColors().green1,
          ),
          SizedBox(
            height: Dimensions.size15,
          ),
          SmallText(
            textAlign: TextAlign.center,
            text: message,
            color: ThemeColors().black,
            size: Dimensions.size15,
          ),
          SizedBox(
            height: Dimensions.size20,
          ),
        ],
      ),
    );
  }
}
