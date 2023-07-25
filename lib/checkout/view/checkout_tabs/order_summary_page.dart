import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:aljouf/checkout/controllers/checkout_controller.dart';
import 'package:aljouf/checkout/view/widgets/custom_checkout_item.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/widgets/custom_button.dart';
import 'package:aljouf/widgets/custom_text.dart';
import 'package:aljouf/widgets/custom_text_field.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({
    super.key,
    required this.checkoutController,
    required this.onEditPurchasesTap,
    required this.onEditAddressTap,
    required this.onEditShippingTap,
    required this.onEditPaymentTap,
    required this.onConfirmOrderTap,
  });

  final CheckoutController checkoutController;
  final VoidCallback onEditPurchasesTap;
  final VoidCallback onEditAddressTap;
  final VoidCallback onEditShippingTap;
  final VoidCallback onEditPaymentTap;
  final VoidCallback onConfirmOrderTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
                    top: 20,
                    bottom: 32,
                  ),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text:
                                '${'purchases'.tr} ( ${checkoutController.order!.products!.length} )',
                            fontWeight: FontWeight.w400,
                          ),
                          InkWell(
                            onTap: onEditPurchasesTap,
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/icons/edit.svg'),
                                const SizedBox(
                                  width: 8,
                                ),
                                CustomText(
                                  text: 'edit'.tr,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(
                        thickness: 1,
                        color: lighGrey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: checkoutController.order!.products!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 28,
                          );
                        },
                        itemBuilder: (context, index) {
                          return CustomCheckoutItem(
                            product: checkoutController.order!.products![index],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
                    top: 20,
                    bottom: 32,
                  ),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'shippingAddress'.tr,
                            fontWeight: FontWeight.w400,
                          ),
                          InkWell(
                            onTap: onEditAddressTap,
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/icons/edit.svg'),
                                const SizedBox(
                                  width: 8,
                                ),
                                CustomText(
                                  text: 'edit'.tr,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(
                        thickness: 1,
                        color: lighGrey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text: checkoutController.order!.shippingAddress!,
                        color: almostBlack,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text:
                            '${checkoutController.order!.shippingCity!} - ${checkoutController.order!.shippingZone!} - ${checkoutController.order!.shippingCountry!.tr}',
                        color: almostBlack,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text:
                            '${checkoutController.order!.shippingFirstName!} ${checkoutController.order!.shippingLastName!}',
                        color: almostBlack,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text: checkoutController.order!.phone!,
                        color: almostBlack,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
                    top: 20,
                    bottom: 32,
                  ),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'shippingInfo'.tr,
                            fontWeight: FontWeight.w400,
                          ),
                          InkWell(
                            onTap: onEditShippingTap,
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/icons/edit.svg'),
                                const SizedBox(
                                  width: 8,
                                ),
                                CustomText(
                                  text: 'edit'.tr,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(
                        thickness: 1,
                        color: lighGrey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: checkoutController.order!.shippingCode ==
                                    'aramex.aramex'
                                ? 'shippingThroughAramex'.tr
                                : checkoutController.order!.shippingCode!,
                            color: almostBlack,
                            fontWeight: FontWeight.w500,
                          ),
                          // if (widget.checkoutController.order!.shippingCode ==
                          //     'aramex.aramex')
                          Image.asset('assets/images/aramex.png'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
                    top: 20,
                    bottom: 32,
                  ),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'paymentInfo'.tr,
                            fontWeight: FontWeight.w400,
                          ),
                          InkWell(
                            onTap: onEditPaymentTap,
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/icons/edit.svg'),
                                const SizedBox(
                                  width: 8,
                                ),
                                CustomText(
                                  text: 'edit'.tr,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(
                        thickness: 1,
                        color: lighGrey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (checkoutController.order!.paymentCode ==
                          'payfort_fort')
                        Image.asset(
                          'assets/images/cards.png',
                          height: 36,
                        )
                      else
                        Image.asset(
                          'assets/images/apple_pay_new.png',
                          height: 50,
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
                    top: 20,
                    bottom: 32,
                  ),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'totalInvoice'.tr,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(
                        thickness: 1,
                        color: lighGrey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: CustomTextField(
                              controller:
                                  checkoutController.couponController.value,
                              validator: false,
                              hintText: 'couponCode'.tr,
                              textInputType: TextInputType.text,
                              readOnly: checkoutController.isCouponAdded.value
                                  ? true
                                  : false,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(() {
                              if (checkoutController.isCouponLoading.value) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return ElevatedButton(
                                onPressed: () {
                                  if (checkoutController.isCouponAdded.value) {
                                    checkoutController.deleteCoupon(
                                      context: context,
                                    );
                                  } else {
                                    checkoutController.addCoupon(
                                      context: context,
                                      coupon: checkoutController
                                          .couponController.value.text,
                                    );
                                  }
                                },
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                        checkoutController.isCouponAdded.value
                                            ? vermillion
                                            : almostBlack),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    fixedSize: MaterialStateProperty.all(
                                        const Size.fromHeight(54)),
                                    shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))))),
                                child: CustomText(
                                  text: checkoutController.isCouponAdded.value
                                      ? 'remove'.tr
                                      : 'apply'.tr,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: checkoutController.order!.totals!.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                    text: checkoutController
                                        .order!.totals![index].title!),
                                CustomText(
                                  text: checkoutController
                                      .order!.totals![index].text!,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            );
                          }),
                      const SizedBox(
                        height: 34,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'total'.tr,
                                color: brownishGrey,
                                fontWeight: FontWeight.w400,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              CustomText(
                                text: checkoutController.order!.total
                                    .toStringAsFixed(2),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                          Row(
                            textDirection: TextDirection.ltr,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/barcode_1.svg',
                                colorFilter: const ColorFilter.mode(
                                  darkGrey,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/icons/barcode_2.svg',
                                colorFilter: const ColorFilter.mode(
                                  darkGrey,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ).copyWith(
              top: 16,
              bottom: 32,
            ),
            child: CustomButton(
              onPressed: onConfirmOrderTap,
              title: 'confirmOrder'.tr,
            ),
          ),
        ],
      ),
    );
  }
}
