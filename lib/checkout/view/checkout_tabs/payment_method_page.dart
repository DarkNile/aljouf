import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/checkout/controllers/checkout_controller.dart';
import 'package:aljouf/checkout/view/widgets/custom_payment_method_card.dart';
import 'package:aljouf/utils/app_util.dart';
import 'package:aljouf/widgets/custom_button.dart';
import 'package:aljouf/widgets/custom_text.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({
    super.key,
    required this.onNextTap,
    required this.checkoutController,
  });

  final Function(int) onNextTap;
  final CheckoutController checkoutController;

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  late bool isChecked;
  late int? checkedIndex;

  @override
  void initState() {
    super.initState();
    if (widget.checkoutController.paymentMethods.length == 1 ||
        Platform.isAndroid) {
      checkedIndex = 0;
      isChecked = true;
    } else {
      checkedIndex = null;
      isChecked = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: 'choosePaymentMethod'.tr),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                itemCount: Platform.isIOS
                    ? widget.checkoutController.paymentMethods.length
                    : widget.checkoutController.paymentMethods
                        .where((element) => element.code == 'paytabs_all')
                        .toList()
                        .length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 16,
                  );
                },
                itemBuilder: (context, index) {
                  return CustomPaymentMethodCard(
                    onTap: () {
                      setState(() {
                        checkedIndex = index;
                        isChecked = !isChecked;
                      });
                    },
                    paymentMethod:
                        widget.checkoutController.paymentMethods[index],
                    isChecked:
                        widget.checkoutController.paymentMethods.length == 1
                            ? true
                            : isChecked && checkedIndex == index,
                    onChanged: (value) {
                      setState(() {
                        checkedIndex = index;
                        isChecked = value;
                      });
                    },
                  );
                }),
          ),
          const SizedBox(
            height: 16,
          ),
          Obx(() {
            if (widget.checkoutController.isAddingPaymentMethodLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return CustomButton(
              radius: 4,
              onPressed: () {
                if (checkedIndex != null && isChecked) {
                  widget.onNextTap(checkedIndex!);
                } else {
                  AppUtil.errorToast(context, 'noPaymentMethod'.tr);
                }
              },
              title: 'next'.tr,
            );
          }),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
