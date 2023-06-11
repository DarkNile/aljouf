import 'package:aljouf/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomAnimatedSmoothIndicator extends StatelessWidget {
  const CustomAnimatedSmoothIndicator({
    super.key,
    required this.activeIndex,
    required this.count,
    this.isBlack = false,
  });

  final int activeIndex;
  final int count;
  final bool isBlack;

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: count,
      effect: CustomizableEffect(
          spacing: 8,
          dotDecoration: DotDecoration(
            color: isBlack
                ? Colors.black.withOpacity(0.2)
                : Colors.white.withOpacity(0.5),
            width: 8,
            height: 8,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          activeDotDecoration: const DotDecoration(
            color: green,
            width: 12,
            height: 12,
            borderRadius: BorderRadius.all(Radius.circular(6)),
          )),
    );
  }
}
