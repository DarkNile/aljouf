import 'package:aljouf/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomProductBorder extends StatelessWidget {
  const CustomProductBorder({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(
            color: secondaryGreen,
          ),
        ),
        child: child,
      ),
    );
  }
}
