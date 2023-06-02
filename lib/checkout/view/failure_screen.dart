import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/home/view/home_screen.dart';
import 'package:aljouf/widgets/custom_text.dart';

class FailureScreen extends StatefulWidget {
  const FailureScreen({super.key});

  @override
  State<FailureScreen> createState() => _FailureScreenState();
}

class _FailureScreenState extends State<FailureScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  Future<void> navigateToHome() async {
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAll(
        () => const HomePage(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(text: 'failure'.tr),
            const SizedBox(
              height: 24,
            ),
            CustomText(text: 'redirect'.tr),
          ],
        ),
      ),
    );
  }
}
