import 'package:carousel_slider/carousel_slider.dart';
import 'package:fridge_it/theme/theme_colors.dart';
import 'package:fridge_it/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 5,
      itemBuilder: ((context, index, realIndex) {
        return Padding(
          padding: EdgeInsets.only(right: Dimensions.size5, left: Dimensions.size5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.size25),
            child: Container(
              color: ThemeColors().green2,
            ),
          ),
        );
      }),
      options: CarouselOptions(
        autoPlay: true,
        height: Dimensions.size160,
        enlargeCenterPage: true,
        autoPlayAnimationDuration: const Duration(
          milliseconds: 1000,
        ),
      ),
    );
  }
}
