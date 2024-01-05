import 'package:aljouf/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey,
      selectedItemColor: primaryGreen,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      selectedLabelStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w300,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w300,
      ),
      items: [
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              colorFilter: ColorFilter.mode(
                currentIndex == 0 ? primaryGreen : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            label: 'home'.tr),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/category.svg',
              colorFilter: ColorFilter.mode(
                  currentIndex == 1 ? primaryGreen : Colors.grey,
                  BlendMode.srcIn),
            ),
            label: 'categories'.tr),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/order.svg',
              colorFilter: ColorFilter.mode(
                  currentIndex == 2 ? primaryGreen : Colors.grey,
                  BlendMode.srcIn),
            ),
            label: 'orders'.tr),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/favorite.svg',
              colorFilter: ColorFilter.mode(
                  currentIndex == 3 ? primaryGreen : Colors.grey,
                  BlendMode.srcIn),
            ),
            label: 'favorites'.tr),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/profile.svg',
              colorFilter: ColorFilter.mode(
                  currentIndex == 4 ? primaryGreen : Colors.grey,
                  BlendMode.srcIn),
            ),
            label: 'profile'.tr),
      ],
      onTap: onTap,
    );
  }
}
