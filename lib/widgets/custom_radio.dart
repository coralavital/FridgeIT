import 'package:fridge_it/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme/theme_colors.dart';
import '../utils/dimensions.dart';


class CustomRadioWidget<T> extends StatelessWidget {
  final SmallText title;
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final double width;
  final double height;

  CustomRadioWidget(
      {required this.title,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      this.width = 20,
      this.height = 20});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.size20),
      child: GestureDetector(
        onTap: () {
          onChanged(this.value);
        },
        child: Row(children: [
          Container(
            height: this.height,
            width: this.width,
            decoration: ShapeDecoration(
              shape: const CircleBorder(),
              gradient: LinearGradient(
                colors: [
                  ThemeColors().black,
                  ThemeColors().black,
                ],
              ),
            ),
            child: Center(
              child: Container(
                height: this.height - 3,
                width: this.width - 3,
                decoration: ShapeDecoration(
                  shape: const CircleBorder(),
                  gradient: LinearGradient(
                    colors: value == groupValue
                        ? [
                            ThemeColors().main,
                            ThemeColors().main,
                          ]
                        : [
                            ThemeColors().light2,
                            ThemeColors().light2,
                          ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: Dimensions.size7,
          ),
          title
        ]),
      ),
    );
  }
}
