import 'package:aljouf/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final Function(int) onTap;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final getStorage = GetStorage();
  final _profileController = Get.put(ProfileController());
  late String? customerId;

  @override
  void initState() {
    super.initState();
    customerId = getStorage.read('customerId');
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: widget.currentIndex,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.black,
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
                  widget.currentIndex == 0 ? Colors.black : Colors.grey,
                  BlendMode.srcIn),
            ),
            label: 'home'.tr),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/category.svg',
              colorFilter: ColorFilter.mode(
                  widget.currentIndex == 1 ? Colors.black : Colors.grey,
                  BlendMode.srcIn),
            ),
            label: 'categories'.tr),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/order.svg',
              colorFilter: ColorFilter.mode(
                  widget.currentIndex == 2 ? Colors.black : Colors.grey,
                  BlendMode.srcIn),
            ),
            label: 'orders'.tr),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/favorite.svg',
              colorFilter: ColorFilter.mode(
                  widget.currentIndex == 3 ? Colors.black : Colors.grey,
                  BlendMode.srcIn),
            ),
            label: 'favorites'.tr),
        if (customerId != null &&
            customerId!.isNotEmpty &&
            customerId == _profileController.user.value.id.toString())
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/profile.svg',
                colorFilter: ColorFilter.mode(
                    widget.currentIndex == 4 ? Colors.black : Colors.grey,
                    BlendMode.srcIn),
              ),
              label: 'profile'.tr),
      ],
      onTap: widget.onTap,
    );
  }
}
