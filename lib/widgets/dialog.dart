import 'package:flutter/material.dart';
import 'package:fridge_it/utils/dimensions.dart';
import 'package:fridge_it/widgets/big_text.dart';
import 'package:fridge_it/widgets/small_text.dart';

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
      backgroundColor: ThemeColors().cream,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                alignment: Alignment.topLeft,
                onPressed: () => Navigator.pop(context, 'Cancel'),
                icon: const Icon(Icons.close_rounded),
                color: ThemeColors().main,
              ),
            ],
          ),
          BigText(
            text: title,
            size: Dimensions.size20,
            fontWeight: FontWeight.w700,
            color: ThemeColors().main,
          ),
          SmallText(
            text: message,
          ),
        ],
      ),
    );
  }
}
