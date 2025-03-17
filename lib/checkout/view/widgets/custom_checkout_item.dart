import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/product/models/product.dart';
import 'package:aljouf/widgets/custom_loading_widget.dart';
import 'package:aljouf/widgets/custom_text.dart';

class CustomCheckoutItem extends StatelessWidget {
  const CustomCheckoutItem({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            child: CachedNetworkImage(
              imageUrl: product.image!,
              placeholder: (context, url) {
                return const CustomLoadingWidget();
              },
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 170,
                child: CustomText(
                  text: product.name!.split('&quot;').join(),
                  height: 2,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomText(
                text: product.price,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: black,
                fontFamily: 'sar',
              ),
              Row(
                children: [
                  CustomText(
                    text: 'quantity'.tr,
                    height: 2,
                    color: brownishGrey,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const CustomText(
                    text: ':',
                    height: 2,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  CustomText(
                    text: product.quantity,
                    height: 2,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
