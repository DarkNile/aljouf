import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/home/controllers/home_controller.dart';
import 'package:aljouf/widgets/custom_body_title.dart';
import 'package:aljouf/widgets/custom_product_card.dart';
import 'package:aljouf/widgets/custom_text.dart';
import 'package:lottie/lottie.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key, required this.homeController});

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomBodyTitle(title: 'favorites'.tr),
        const SizedBox(
          height: 20,
        ),
        Obx(() {
          if (homeController.isWishListProductsLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (homeController.wishlistProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lottie/no_orders.json',
                  ),
                  CustomText(
                    text: 'noAvailableProducts'.tr,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: homeController.wishlistProducts.length,
                itemBuilder: (context, index) {
                  return CustomProductCard(
                    product: homeController.wishlistProducts[index],
                    categoryId: '',
                  );
                }),
          );
        }),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
