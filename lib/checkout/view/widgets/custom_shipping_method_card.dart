import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aljouf/checkout/models/shipping_method.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/widgets/custom_text.dart';

class CustomShippingMethodCard extends StatelessWidget {
  const CustomShippingMethodCard({
    super.key,
    required this.shippingMethod,
    required this.onTap,
    required this.onChanged,
    required this.isChecked,
  });

  final VoidCallback onTap;
  final ShippingMethod shippingMethod;
  final ValueChanged onChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isChecked ? secondaryGreen.withOpacity(0.06) : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          border: Border.all(color: isChecked ? secondaryGreen : darkGrey),
        ),
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                fillColor: MaterialStateProperty.all(secondaryGreen),
                checkColor: Colors.white,
                value: isChecked,
                shape: const CircleBorder(),
                onChanged: onChanged,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 4,
                ),
                CustomText(
                  text: shippingMethod.quote.first.code == 'aramex.aramex'
                      ? 'shippingThroughAramex'.tr
                      : shippingMethod.title,
                  color: black,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 4,
                ),
                CustomText(
                  text: shippingMethod.quote.first.text,
                  color: black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
            const Spacer(),
            // if (shippingMethod.quote.first.code == 'aramex.aramex')
            Image.asset(
              'assets/images/saee_aramex.png',
              width: 100,
            ),
          ],
        ),
      ),
    );
  }
}
