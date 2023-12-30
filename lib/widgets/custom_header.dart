import 'package:aljouf/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/widgets/custom_text.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  const CustomHeader({super.key, required this.title, this.onTapBack});

  final String title;
  final VoidCallback? onTapBack;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      toolbarHeight: 44,
      title: CustomText(
        text: title,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        textAlign: TextAlign.center,
        color: secondaryGreen,
      ),
      leading: IconButton(
        onPressed: () {
          if (onTapBack != null) {
            onTapBack!();
          } else {
            Get.back();
          }
        },
        icon: const Icon(
          Icons.arrow_back_outlined,
          color: secondaryGreen, // black,
          size: 24,
        ),
      ),
    );
  }
}
