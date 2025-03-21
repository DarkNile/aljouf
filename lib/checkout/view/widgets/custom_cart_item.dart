import 'package:aljouf/utils/app_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:aljouf/checkout/controllers/checkout_controller.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/product/models/product.dart';
import 'package:aljouf/widgets/custom_loading_widget.dart';
import 'package:aljouf/widgets/custom_text.dart';
import 'dart:math' as math;

class CustomCartItem extends StatelessWidget {
  const CustomCartItem({
    super.key,
    required this.product,
    required this.checkoutController,
    required this.onDeleteTap,
    required this.onIncrementTap,
    required this.onDecrementTap,
  });

  final Product product;
  final CheckoutController checkoutController;
  final VoidCallback onDeleteTap;
  final VoidCallback onIncrementTap;
  final VoidCallback onDecrementTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CachedNetworkImage(
                  imageUrl: product.originalImage!,
                  placeholder: (context, url) {
                    return const CustomLoadingWidget();
                  },
                ),
                if (product.qty == '0' || product.qty == 0)
                  Positioned.directional(
                    textDirection: Directionality.of(context),
                    top: AppUtil.rtlDirection(context) ? 4 : 10,
                    start: AppUtil.rtlDirection(context) ? -8 : -10,
                    child: Transform.rotate(
                      angle: AppUtil.rtlDirection(context)
                          ? math.pi / 5.0
                          : math.pi / -5.0,
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          color: vermillion,
                        ),
                        child: CustomText(
                          text: 'notAvailable'.tr,
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
              ],
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
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: product.special != null && product.special != 0
                          ? double.parse(product.special).toStringAsFixed(2)
                          : double.parse(product.priceRaw.toString())
                              .toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: primaryGreen,
                      ),
                    ),
                    TextSpan(
                      text: ' ${'riyal'.tr}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: primaryGreen,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'sar',
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: onIncrementTap,
                          child: Container(
                            width: 32,
                            height: 36,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: pinkishGrey,
                              ),
                            ),
                            child: const CustomText(
                              text: '+',
                              color: black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          width: 51,
                          height: 36,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            border: Border.symmetric(
                              horizontal: BorderSide(
                                color: pinkishGrey,
                              ),
                            ),
                          ),
                          child: CustomText(
                            text: product.quantity,
                            color: black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        InkWell(
                          onTap: onDecrementTap,
                          child: Container(
                            width: 32,
                            height: 36,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: pinkishGrey,
                              ),
                            ),
                            child: const CustomText(
                              text: '-',
                              color: black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: onDeleteTap,
                      child: SvgPicture.asset(
                        'assets/icons/delete.svg',
                        colorFilter: const ColorFilter.mode(
                          vermillion,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
