import 'package:flutter/material.dart';
import 'package:aljouf/constants/colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = Colors.black,
    this.foregroundColor = Colors.white,
    this.radius = 4,
  });

  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color foregroundColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        fixedSize: MaterialStateProperty.all(
          Size(
            MediaQuery.of(context).size.width,
            48,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        foregroundColor: MaterialStateProperty.all(foregroundColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
        ),
        side: MaterialStateProperty.all(
          const BorderSide(
            color: green,
          ),
        ),
      ),
      child: child,
    );
  }
}
