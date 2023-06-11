import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aljouf/widgets/custom_text.dart';

class CustomFeatureCard extends StatelessWidget {
  const CustomFeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final String icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 14,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset('assets/icons/$icon.svg'),
          CustomText(
            text: title,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
          CustomText(
            text: subtitle,
            fontSize: 9,
          ),
        ],
      ),
    );
  }
}
