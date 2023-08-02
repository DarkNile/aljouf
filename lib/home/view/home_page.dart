import 'dart:io';

import 'package:aljouf/auth/view/login_screen.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/home/view/bottom_nav_screens/category_screen.dart';
import 'package:aljouf/home/view/bottom_nav_screens/favorite_screen.dart';
import 'package:aljouf/home/view/bottom_nav_screens/home_screen.dart';
import 'package:aljouf/home/view/bottom_nav_screens/order_screen.dart';
import 'package:aljouf/home/view/bottom_nav_screens/profile_screen.dart';
import 'package:aljouf/home/view/sub_category_screen.dart';
import 'package:aljouf/utils/app_util.dart';
import 'package:aljouf/widgets/custom_text.dart';
import 'package:android_id/android_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_version_checker/flutter_app_version_checker.dart';
import 'package:get/get.dart';
import 'package:aljouf/auth/controllers/auth_controller.dart';
import 'package:aljouf/home/controllers/home_controller.dart';
import 'package:aljouf/profile/controllers/profile_controller.dart';
import 'package:aljouf/widgets/custom_drawer.dart';
import 'package:aljouf/product/view/products_screen.dart';
import 'package:aljouf/widgets/custom_app_bar.dart';
import 'package:aljouf/widgets/custom_bottom_navigation_bar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.pageIndex});

  final int? pageIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final getStorage = GetStorage();
  final _homeController = Get.put(HomeController());
  final _profileController = Get.put(ProfileController());
  final _authController = Get.put(AuthController());
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController _pageController;
  late int _currentIndex;
  final _checker = AppVersionChecker();
  late String? customerId;

  @override
  void initState() {
    super.initState();
    customerId = getStorage.read('customerId');
    _pageController = PageController(initialPage: widget.pageIndex ?? 0);
    _currentIndex = widget.pageIndex ?? 0;
    checkAppVersion();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _currentIndex == 2 ? null : Colors.white,
      appBar: CustomAppBar(
        scaffoldKey: _scaffoldKey,
      ),
      drawer: CustomDrawer(
        onProfileTileTap: () {
          Get.back();
          setState(() {
            _currentIndex = 4;
          });
          _pageController.jumpToPage(_currentIndex);
        },
        onHomeTileTap: () {
          Get.back();
          setState(() {
            _currentIndex = 0;
          });
          _pageController.jumpToPage(_currentIndex);
        },
        onCategoryTileTap: (String id, String name) {
          Get.back();
          if (id == '228') {
            Get.to(
              () => SubCategoryScreen(
                homeController: _homeController,
                categoryName: name,
              ),
            );
          } else {
            Get.to(
              () => ProductsScreen(
                categoryId: id,
                categoryName: name,
              ),
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index == 4) {
              if (customerId != null &&
                  customerId!.isNotEmpty &&
                  customerId == _profileController.user.value.id.toString()) {
                setState(() {
                  _currentIndex = index;
                });
                _pageController.jumpToPage(_currentIndex);
              } else {
                Get.to(() => const LoginScreen());
              }
            } else {
              setState(() {
                _currentIndex = index;
              });
              _pageController.jumpToPage(_currentIndex);
            }
          }),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          HomeScreen(homeController: _homeController),
          CategoryScreen(homeController: _homeController),
          OrderScreen(profileController: _profileController),
          FavoriteScreen(homeController: _homeController),
          ProfileScreen(
            profileController: _profileController,
            authController: _authController,
          ),
        ],
      ),
    );
  }

  Future<void> checkAppVersion() async {
    await _checker.checkUpdate().then((value) async {
      print(value.canUpdate); //return true if update is available
      print(value.currentVersion); //return current app version
      print(value.newVersion); //return the new app version
      print(value.appURL); //return the app url
      print(value
          .errorMessage); //return error message if found else it will return null
      if (value.canUpdate) {
        await AppUtil.dialog2(
          context,
          'versionTitle'.tr,
          [
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size.fromHeight(40)),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
              onPressed: () async {
                await launchUrlString(
                  value.appURL!,
                );
              },
              child: CustomText(
                text: 'updateNow'.tr,
                textAlign: TextAlign.center,
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          barrierDismissible: false,
        );
      }
    });
    //
    String? deviceId;
    if (Platform.isIOS) {
      var deviceInfo = DeviceInfoPlugin();
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      const androidId = AndroidId();
      deviceId = await androidId.getId();
    }
    print('Device ID: $deviceId'); // unique Device ID
    var doc = await FirebaseFirestore.instance
        .collection('Devices')
        .doc(deviceId)
        .get();
    if (doc.exists) {
      print('exists ${doc.id}');
    } else {
      if (customerId != null &&
          customerId!.isNotEmpty &&
          customerId == _profileController.user.value.id.toString()) {
        final coupon =
            await _homeController.createCoupon(customerId: customerId!);
        if (coupon != null && context.mounted) {
          await AppUtil.dialog2(
            context,
            'congratulationsCoupon'.tr,
            [
              SelectableText(
                coupon,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: brown,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize:
                      MaterialStateProperty.all(const Size.fromHeight(40)),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('Devices')
                      .doc(deviceId)
                      .set({'deviceId': deviceId});
                  Get.back();
                },
                child: CustomText(
                  text: 'shopNow'.tr,
                  textAlign: TextAlign.center,
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            barrierDismissible: false,
          );
        }
      } else {
        if (context.mounted) {
          await AppUtil.dialog2(
            context,
            'congratulationsCoupon'.tr,
            [
              CustomText(
                text: 'loginToCoupon'.tr,
                textAlign: TextAlign.center,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: vermillion,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize:
                      MaterialStateProperty.all(const Size.fromHeight(40)),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
                onPressed: () async {
                  Get.to(() => const LoginScreen());
                },
                child: CustomText(
                  text: 'signIn'.tr,
                  textAlign: TextAlign.center,
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            barrierDismissible: false,
          );
        }
      }
    }
  }
}
