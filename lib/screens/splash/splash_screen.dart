import 'package:aljouf/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/checkout/controllers/checkout_controller.dart';
import 'package:aljouf/home/controllers/home_controller.dart';
import 'package:aljouf/profile/controllers/profile_controller.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _getStorage = GetStorage();
  final _homeController = Get.put(HomeController());
  final _profileController = Get.put(ProfileController());
  final _checkoutController = Get.put(CheckoutController());

  @override
  void initState() {
    super.initState();
    animateSplash();
  }

  Future<void> animateSplash() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeController.getBanners(id: '9');
      _homeController.getWishlistProducts(isFromHome: true);
      _homeController.getBanners(id: '11');
      _homeController.getBanners(id: '12');
      _homeController.getBanners(id: '10');
      _profileController.getAccount();
      final String? token = _getStorage.read('token');
      if (token == null || token.isEmpty) {
        _checkoutController.clearCart();
      } else {
        _checkoutController.getCartItems();
      }
    });
    Future.delayed(
        const Duration(
          seconds: 3,
        ), () {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const HomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Image.asset(
        'assets/images/splash.gif',
        width: width,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
