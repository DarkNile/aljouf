import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aljouf/constants/colors.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.icon,
    required this.onTap,
    this.height = 39,
    this.radius = 4,
    this.width,
  });

  final String icon;
  final VoidCallback onTap;
  final double height;
  final double radius;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          border: Border.all(
            color: lighGrey,
          ),
        ),
        child: SvgPicture.asset('assets/icons/$icon.svg'),
      ),
    );
  }
}
