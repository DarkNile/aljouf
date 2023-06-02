import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:aljouf/checkout/controllers/checkout_controller.dart';
import 'package:aljouf/checkout/view/widgets/custom_checkout_item.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/widgets/custom_button.dart';
import 'package:aljouf/widgets/custom_text.dart';
import 'package:aljouf/widgets/custom_text_field.dart';

class OrderSummaryPage extends StatefulWidget {
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
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  final _couponController = TextEditingController();
  bool isCouponAdded = false;

  @override
  void dispose() {
    super.dispose();
    _couponController.dispose();
  }

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
                                '${'purchases'.tr} ( ${widget.checkoutController.order!.products!.length} )',
                            fontWeight: FontWeight.w400,
                          ),
                          InkWell(
                            onTap: widget.onEditPurchasesTap,
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
                        itemCount:
                            widget.checkoutController.order!.products!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 28,
                          );
                        },
                        itemBuilder: (context, index) {
                          return CustomCheckoutItem(
                            product: widget
                                .checkoutController.order!.products![index],
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
                            onTap: widget.onEditAddressTap,
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
                        text: widget.checkoutController.order!.shippingAddress!,
                        color: almostBlack,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text:
                            '${widget.checkoutController.order!.shippingCity!} - ${widget.checkoutController.order!.shippingZone!} - ${widget.checkoutController.order!.shippingCountry!.tr}',
                        color: almostBlack,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text:
                            '${widget.checkoutController.order!.shippingFirstName!} ${widget.checkoutController.order!.shippingLastName!}',
                        color: almostBlack,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text: widget.checkoutController.order!.phone!,
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
                            onTap: widget.onEditShippingTap,
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
                            text:
                                widget.checkoutController.order!.shippingCode ==
                                        'aramex.aramex'
                                    ? 'shippingThroughAramex'.tr
                                    : widget.checkoutController.order!
                                        .shippingCode!,
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
                            onTap: widget.onEditPaymentTap,
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
                      if (widget.checkoutController.order!.paymentCode ==
                          'payfort_fort')
                        Image.asset(
                          'assets/images/cards.png',
                          height: 36,
                        )
                      else
                        Image.asset(
                          'assets/images/apple_pay.png',
                          height: 20,
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
                              controller: _couponController,
                              validator: false,
                              hintText: 'couponCode'.tr,
                              textInputType: TextInputType.text,
                              readOnly: isCouponAdded ? true : false,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(() {
                              if (widget
                                  .checkoutController.isCouponLoading.value) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return ElevatedButton(
                                onPressed: () async {
                                  if (isCouponAdded) {
                                    final isSuccess = await widget
                                        .checkoutController
                                        .deleteCoupon(
                                      context: context,
                                    );
                                    if (isSuccess) {
                                      setState(() {
                                        isCouponAdded = false;
                                      });
                                    }
                                  } else {
                                    final isSuccess = await widget
                                        .checkoutController
                                        .addCoupon(
                                            context: context,
                                            coupon: _couponController.text);
                                    if (isSuccess) {
                                      setState(() {
                                        isCouponAdded = true;
                                      });
                                    }
                                  }
                                },
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                        isCouponAdded
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
                                  text:
                                      isCouponAdded ? 'remove'.tr : 'apply'.tr,
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
                          itemCount:
                              widget.checkoutController.order!.totals!.length,
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
                                    text: widget.checkoutController.order!
                                        .totals![index].title!),
                                CustomText(
                                  text: widget.checkoutController.order!
                                      .totals![index].text!,
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
                                text: widget.checkoutController.order!.total
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
              onPressed: widget.onConfirmOrderTap,
              title: 'confirmOrder'.tr,
            ),
          ),
        ],
      ),
    );
  }
}
