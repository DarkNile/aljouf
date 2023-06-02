import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/product/widgets/custom_review_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/product/models/product.dart';
import 'package:aljouf/widgets/custom_text.dart';

class RatingReviewScreen extends StatelessWidget {
  const RatingReviewScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    if (product.reviews!.reviewTotal == '0') {
      return Center(
        child: CustomText(
          text: 'noReviews'.tr,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: brownishGrey,
        ),
      );
    } else {
      return ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: product.reviews!.reviews!.length,
          separatorBuilder: (context, index) {
            return const Divider(
              height: 32,
            );
          },
          itemBuilder: (context, index) {
            return CustomReviewItem(
              review: product.reviews!.reviews![index],
            );
          });
    }
  }
}
