import 'package:fridge_it/widgets/custom_button.dart';
import 'package:fridge_it/widgets/small_text.dart';
import 'package:fridge_it/utils/dimensions.dart';
import 'package:fridge_it/widgets/big_text.dart';
import 'package:flutter/material.dart';
import '../theme/theme_colors.dart';

class CustomDialog extends StatelessWidget {
  BigText title;
  SmallText message;
  CustomButton? button1;
  CustomButton? button2;

  CustomDialog(
      {super.key,
      required this.title,
      required this.message,
      this.button1,
      this.button2});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentTextStyle: const TextStyle(wordSpacing: 2),
      backgroundColor: ThemeColors().background,
      content: Column(
        mainAxisSize: MainAxisSize.min,
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
          title,
          SizedBox(
            height: Dimensions.size15,
          ),
          message,
          SizedBox(
            height: Dimensions.size20,
          ),
          button1 != null && button2 != null ?Row(
            children: [
              button1!,
              button2!,
            ],
          ) : const SizedBox()
        ],
      ),
    );
  }
}
