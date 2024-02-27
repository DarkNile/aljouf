import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/checkout/controllers/checkout_controller.dart';
import 'package:aljouf/checkout/view/widgets/custom_shipping_method_card.dart';
import 'package:aljouf/utils/app_util.dart';
import 'package:aljouf/widgets/custom_button.dart';
import 'package:aljouf/widgets/custom_text.dart';

class ShippingMethodPage extends StatefulWidget {
  const ShippingMethodPage({
    super.key,
    required this.onNextTap,
    required this.checkoutController,
  });

  final Function(int) onNextTap;

  final CheckoutController checkoutController;

  @override
  State<ShippingMethodPage> createState() => _ShippingMethodPageState();
}

class _ShippingMethodPageState extends State<ShippingMethodPage> {
  late bool isChecked;
  late int? checkedIndex;

  @override
  void initState() {
    super.initState();
    // if (widget.checkoutController.shippingMethods.length == 1) {
    //   checkedIndex = 0;
    //   isChecked = true;
    // } else {
    checkedIndex = null;
    isChecked = false;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: 'chooseShippingMethod'.tr),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                itemCount: widget.checkoutController.shippingMethods.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 16,
                  );
                },
                itemBuilder: (context, index) {
                  return CustomShippingMethodCard(
                    onTap: () {
                      setState(() {
                        checkedIndex = index;
                        isChecked = !isChecked;
                      });
                    },
                    shippingMethod:
                        widget.checkoutController.shippingMethods[index],
                    isChecked:
                        // widget.checkoutController.shippingMethods.length == 1
                        //     ? true
                        //     :
                        isChecked && checkedIndex == index,
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
            if (widget.checkoutController.isAddingShippingMethodLoading.value) {
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
                  AppUtil.errorToast(context, 'noShippingMethod'.tr);
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
