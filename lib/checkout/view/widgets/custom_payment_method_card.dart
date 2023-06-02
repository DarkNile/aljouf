import 'package:flutter/material.dart';
import 'package:aljouf/checkout/models/payment_method.dart';
import 'package:aljouf/constants/colors.dart';

class CustomPaymentMethodCard extends StatelessWidget {
  const CustomPaymentMethodCard({
    super.key,
    required this.paymentMethod,
    required this.onTap,
    required this.onChanged,
    required this.isChecked,
  });

  final VoidCallback onTap;
  final PaymentMethod paymentMethod;
  final ValueChanged onChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isChecked ? jadeGreen.withOpacity(0.06) : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          border: Border.all(color: isChecked ? jadeGreen : darkGrey),
        ),
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                fillColor: MaterialStateProperty.all(jadeGreen),
                checkColor: Colors.white,
                value: isChecked,
                shape: const CircleBorder(),
                onChanged: onChanged,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            if (paymentMethod.code == 'payfort_fort')
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
    );
  }
}
