import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:aljouf/home/controllers/home_controller.dart';
import 'package:aljouf/utils/app_util.dart';
import 'package:aljouf/widgets/custom_text.dart';

class StaticPage extends StatelessWidget {
  const StaticPage({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (homeController.isStaticPageLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: homeController.staticPageData['title']!,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: AppUtil.rtlDirection(context)
                            ? SvgPicture.asset('assets/icons/left_arrow.svg')
                            : SvgPicture.asset('assets/icons/right_arrow.svg'),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: CustomText(
                  text: homeController.staticPageData['description']!
                      .split('&nbsp;')
                      .join(),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
