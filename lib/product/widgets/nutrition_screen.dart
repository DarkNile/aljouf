import 'package:aljouf/product/models/custom_tabs.dart';
import 'package:aljouf/widgets/custom_body_title.dart';
import 'package:aljouf/widgets/custom_header.dart';
import 'package:aljouf/widgets/custom_loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key, required this.customtabs});

  final Customtabs customtabs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomHeader(title: 'nutritionFacts'.tr),
      body: Column(
        children: [
          CustomBodyTitle(title: 'nutritionFacts'.tr),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              itemCount: customtabs.customtabs!.length,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 24,
                );
              },
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: customtabs.customtabs![index].image!,
                  placeholder: (context, url) {
                    return const CustomLoadingWidget();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
