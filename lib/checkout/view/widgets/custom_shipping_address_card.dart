import 'package:flutter/material.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/profile/models/address.dart';
import 'package:aljouf/widgets/custom_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomShippingAddressCard extends StatelessWidget {
  const CustomShippingAddressCard({
    super.key,
    required this.address,
    required this.onTap,
    required this.onChanged,
    required this.isChecked,
    required this.phoneNumber,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  final VoidCallback onTap;
  final Address address;
  final ValueChanged onChanged;
  final bool isChecked;
  final String phoneNumber;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isChecked ? jadeGreen.withOpacity(0.06) : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          border: Border.all(color: isChecked ? jadeGreen : darkGrey),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        text: address.address,
                        color: almostBlack,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: width * 0.7,
                        child: CustomText(
                          text:
                              '${address.city} - ${address.zone} - ${address.country.tr}',
                          color: brownishGrey,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: width * 0.7,
                        height: 1,
                        color: lighGrey,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomText(
                        text: '${address.firstName} ${address.lastName}',
                        color: brownishGrey,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text: phoneNumber,
                        color: almostBlack,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 41,
              decoration: BoxDecoration(
                color: isChecked ? jadeGreen.withOpacity(0.06) : lighGrey,
                border: const Border(
                  top: BorderSide(color: darkGrey),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: onEditTap,
                      child: Row(
                        children: [
                          const Spacer(),
                          SvgPicture.asset(
                            'assets/icons/edit.svg',
                            colorFilter: const ColorFilter.mode(
                              Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          CustomText(
                            text: 'edit'.tr,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 41,
                    width: 1,
                    color: darkGrey,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: onDeleteTap,
                      child: Row(
                        children: [
                          const Spacer(),
                          SvgPicture.asset(
                            'assets/icons/delete.svg',
                            colorFilter: const ColorFilter.mode(
                              Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          CustomText(
                            text: 'delete'.tr,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
