import 'package:aljouf/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:aljouf/utils/app_util.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 12,
    this.textAlign,
    this.fontWeight = FontWeight.w300,
    this.color = black,
    this.textDecoration,
    this.maxlines,
    this.textOverflow,
    this.textDirection,
    this.height,
    this.fontFamily,
  });

  final String text;
  final double fontSize;
  final TextAlign? textAlign;
  final FontWeight fontWeight;
  final Color color;
  final TextDecoration? textDecoration;
  final int? maxlines;
  final TextOverflow? textOverflow;
  final TextDirection? textDirection;
  final double? height;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ??
          (AppUtil.rtlDirection(context) ? TextAlign.right : TextAlign.left),
      maxLines: maxlines,
      overflow: textOverflow,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: textDecoration,
        height: height,
        fontFamily: fontFamily,
      ),
      textDirection: textDirection ??
          (AppUtil.rtlDirection(context)
              ? TextDirection.rtl
              : TextDirection.ltr),
    );
  }
}
