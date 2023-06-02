import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/profile/models/address.dart';
import 'package:aljouf/widgets/custom_text.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.address,
    required this.length,
    required this.onEditTap,
    required this.onDeleteTap,
    required this.phoneNumber,
  });

  final Address address;
  final int length;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        side: BorderSide(color: darkGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18).copyWith(top: 18),
            child: CustomText(
              text: address.address,
              color: almostBlack,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: CustomText(
              text: '${address.city} - ${address.zone} - ${address.country.tr}',
              color: brownishGrey,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Divider(),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: CustomText(
              text: '${address.firstName} ${address.lastName}',
              color: brownishGrey,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: CustomText(
              text: phoneNumber,
              color: almostBlack,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          Container(
            height: 41,
            decoration: const BoxDecoration(
              color: lighGrey,
              border: Border(
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
    );
  }
}
