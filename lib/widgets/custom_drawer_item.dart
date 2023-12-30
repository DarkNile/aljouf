import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/widgets/custom_text.dart';

class CustomDrawerTile extends StatelessWidget {
  const CustomDrawerTile({
    super.key,
    required this.onTap,
    required this.title,
    required this.leadingIcon,
    this.trailing,
    this.subtitle,
    this.leading,
  });

  final VoidCallback onTap;
  final String title;
  final String leadingIcon;
  final Widget? trailing;
  final Widget? subtitle;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      splashColor: lightGreen,
      dense: true,
      onTap: onTap,
      title: CustomText(
        text: title.tr,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: black,
      ),
      leading: leading ??
          SizedBox(
            width: 24,
            // height: 20,
            child: SvgPicture.asset(
              'assets/icons/$leadingIcon.svg',
              colorFilter: const ColorFilter.mode(
                secondaryGreen,
                BlendMode.srcIn,
              ),
            ),
          ),
      contentPadding: const EdgeInsets.all(0),
      minVerticalPadding: 0,
      minLeadingWidth: 0,
      trailing: trailing,
      subtitle: subtitle,
    );
  }
}
